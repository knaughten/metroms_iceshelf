#include "cppdefs.h"
      MODULE brine_rejection_mod
#if defined CICE_OCEAN
# if defined BRINE_REJECTION
!  Spread salt fluxes from sea ice formation uniformly through the "mixed layer"!  (defined with lower boundary having density 0.4 kg/m^3 greater than the
!  surface layer).
!  Reference: P.B. Duffy, M. Eby, and A.J. Weaver, 1999: Effects of sinking of
!             salt rejected during formation of sea ice on results of an
!             ocean-atmosphere-sea ice climate model. Geophysical Research
!             Letters 26(12): 1739-1742.
      use mod_kinds, only: r8

      implicit none

      PRIVATE
      PUBLIC brine_rejection

      CONTAINS

      SUBROUTINE brine_rejection (ng, tile)

      USE mod_param
      USE mod_grid
      USE mod_ocean
      USE mod_stepping
      USE mod_ice

      integer, intent(in) :: ng, tile

#  include "tile.h"

#  ifdef PROFILE
      CALL wclock_on (ng, iNLM, 44)
#  endif

      CALL brine_rejection_tile (ng, tile,                              &
     &                    LBi, UBi, LBj, UBj,                           &
     &                    nnew(ng),                                     &
#  ifdef MASKING
     &                    GRID(ng) % rmask,                             &
#  endif
#  ifdef WET_DRY
     &                    GRID(ng) % rmask_wet,                         &
#  endif
     &                    GRID(ng) % Hz,                                &
     &                    OCEAN(ng) % t,                                &
     &                    OCEAN(ng) % rho,                              &
     &                    ICE(ng) % freshiAI,                           &
     &                    ICE(ng) % fsaltiAI)
#  ifdef PROFILE
      CALL wclock_off (ng, iNLM, 44)
#  endif
      RETURN
      END SUBROUTINE brine_rejection


      SUBROUTINE brine_rejection_tile (ng, tile,                        &
     &                LBi, UBi, LBj, UBj,                               &
     &                nnew,                                             &
#  ifdef MASKING
     &                rmask,                                            &
#  endif
#  ifdef WET_DRY
     &                rmask_wet,                                        &
#  endif
     &                Hz, t, rho, freshiAI, fsaltiAI)

      USE mod_param
      USE mod_scalars

#  ifdef EW_PERIODIC || defined NS_PERIODIC
      USE exchange_3d_mod, ONLY : exchange_r3d_tile
#  endif
#  ifdef DISTRIBUTE
      USE mp_exchange_mod
#  endif

      implicit none

! Imported variable declarations.
      integer, intent(in) :: ng, tile
      integer, intent(in) :: LBi, UBi, LBj, UBj
      integer, intent(in) :: nnew

#  ifdef ASSUMED_SHAPE
#   ifdef MASKING
      real(r8), intent(in) :: rmask(LBi:,LBj:)
#   endif
#   ifdef WET_DRY
      real(r8), intent(in) :: rmask_wet(LBi:,LBj:)
#   endif
      real(r8), intent(in) :: Hz(LBi:,LBj:,:)
      real(r8), intent(inout) :: t(LBi:,LBj:,:,:,:)
      real(r8), intent(in) :: rho(LBi:,LBj:,:)
      real(r8), intent(in) :: freshiAI(LBi:,LBj:)
      real(r8), intent(in) :: fsaltiAI(LBi:,LBj:)
#  else
#   ifdef MASKING
      real(r8), intent(in) :: rmask(LBi:UBi,LBj:UBj)
#   endif
#   ifdef WET_DRY
      real(r8), intent(in) :: rmask_wet(LBi:UBi,LBj:UBj)
#   endif
      real(r8), intent(in) :: Hz(LBi:UBi,LBj:UBj,N(ng))
      real(r8), intent(inout) :: t(LBi:UBi,LBj:UBj,N(ng),3,NT(ng))
      real(r8), intent(in) :: rho(LBi:UBi,LBj:UBj,N(ng))
      real(r8), intent(in) :: freshiAI(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: fsaltiAI(LBi:UBi,LBj:UBj)
#  endif

! Local variable definitions.

      integer :: i, j, k, kml

      real(r8), parameter :: rho_cri = 0.4_r8
      real(r8) :: cff, brine, dz_sum

#  include "set_bounds.h"

      cff = -dt(ng)/rhow

      DO j=Jstr,Jend
        DO i=Istr,Iend
#  ifdef MASKING
          IF (rmask(i,j) .ne. 0.0_r8) THEN
#  endif
#  ifdef WET_DRY
          IF (rmask_wet(i,j) .ne. 0.0_r8) THEN
#  endif
          ! Calculate the amount of brine coming in at the surface
          ! Units of psu*m
          brine=cff*(freshiAI(i,j)*t(i,j,N(ng),nnew,isalt)-             &
     &                 fsaltiAI(i,j)*1000.0_r8)
          ! Start a sum of the total depth over the "mixed layer"
          dz_sum=Hz(i,j,N(ng))
          ! Initialise index of the bottom boundary of the "mixed layer"
          kml=N(ng)
          ! Loop downwards
          DO k=N(ng)-1,1,-1
             ! Check if density exceeds 0.4 kg/m^3 plus the surface density
             IF (rho(i,j,k).gt.(rho(i,j,N(ng))+rho_cri)) EXIT
             ! Update depth sum and mixed layer index
             dz_sum=dz_sum+Hz(i,j,k)
             kml=kml-1
          END DO
          ! Loop over the "mixed layer"
          DO k=N(ng),kml,-1
             ! Increase salinity uniformly
             t(i,j,k,nnew,isalt) = t(i,j,k,nnew,isalt) +                &
     &                             brine/dz_sum
          END DO
#   ifdef MASKING
          END IF
#   endif
#   ifdef WET_DRY
          END IF
#   endif
        END DO
      END DO

! Update periodic boundary conditions for salinity
#   if defined EW_PERIODIC || defined NS_PERIODIC
      CALL exchange_r3d_tile (ng, tile,                                 &
     &                        LBi, UBi, LBj, UBj, 1, N(ng),             &
     &                        t(:,:,:,nnew,isalt))
#   endif
! Update tiles
#   ifdef DISTRIBUTE
      CALL mp_exchange3d (ng, tile, iNLM, 1,                            &
     &                  LBi, UBi, LBj, UBj, 1, N(ng),                   &
     &                  NghostPoints, EWperiodic(ng), NSperiodic(ng),   &
     &                  t(:,:,:,nnew,isalt))
#   endif
      RETURN
      END SUBROUTINE brine_rejection_tile
# endif
#endif
      END MODULE brine_rejection_mod

#ifdef ROMSCOUPLED
! Stuff ice accum needs to share with other modules so to avoid circular
! dependencies

      module ice_accum_shared
      use ice_kinds_mod
      implicit none

      logical (kind=log_kind), public :: &
               bool_accum_write = .true., &  ! if .true., write age tracer restartfile
               bool_accum_read = .false.     ! same but for reading

      real (kind=dbl_kind), public :: accum_time

!jd Coupling fields and indexes
      integer, parameter, public :: nfields = 9,  &
         idaice=1, &
         idfresh=2, &
	 idfreshi=3, &
         idfsalt=4, &
	 idfsalti=5, &
         idfhocn=6, &
         idfswthru=7, &
         idstrocnx=8, &
         idstrocny=9 

      end module ice_accum_shared
#endif

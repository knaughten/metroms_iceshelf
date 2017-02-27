/*
** svn $Id: basin.h 8 2007-02-06 19:00:29Z arango $
*******************************************************************************
** Copyright (c) 2002-2007 The ROMS/TOMS Group
**
**   Licensed under a MIT/X style license
**
**   See License_ROMS.txt
**
*******************************************************************************
**
**  Options for ROMS
*/
#define CIRCUMPOLAR
#define PROFILE

#undef  RST_SINGLE         /* define if single precision restart fields */
#undef  PERFECT_RESTART    /* use to include perfect restart variables */
#define CURVGRID           /* define if using  curvilinear coordinate grid*/

#undef  DIAGNOSTICS_UV     /* define if writing out dynamics to diagnostics file*/
#undef  DIAGNOSTICS_TS     /* define if writing out tracers  to diagnostics file*/

#define UV_ADV             /* turn ON or OFF advection terms */
#define UV_COR             /* turn ON or OFF Coriolis term */
#undef UV_VIS2            /* turn ON or OFF Laplacian horizontal mixing */
#define UV_VIS4            /* turn ON or OFF biharmonic horizontal mixing */
#undef UV_SADVECTION      /* turn ON or OFF splines vertical advection */
#define UV_QDRAG           /* turn ON or OFF quadratic bottom friction */
#undef  UV_SMAGORINSKY

#define VISC_GRID          /* viscosity coefficient scaled by grid size */
#define NONLIN_EOS         /* define if using nonlinear equation of state */
#undef  WJ_GRADP           /* Weighted density Jacobian (Song, 1998) */
#define DJ_GRADPS          /* Splines density  Jacobian (Shchepetkin, 2000) */
#define DIFF_GRID          /* diffusion coefficient scaled by grid size */

#define TS_DIF2            /* turn ON or OFF Laplacian horizontal mixing */
#undef TS_DIF4            /* turn ON or OFF biharmonic horizontal mixing */
#define TS_U3HADVECTION    /* define if 3rd-order upstream horiz. advection */
#undef  TS_A4HADVECTION    /* define if 4th-order Akima horiz. advection */
#undef  TS_C4HADVECTION    /* define if 4th-order centered horizontal advection */

#undef TS_MPDATA          /* define if recursive MPDATA 3D advection */

#ifdef TS_U3HADVECTION
# define UPWIND_LIMITER
#endif

#undef TS_A4VADVECTION    /* define if 4th-order Akima vertical advection */
#undef TS_SVADVECTION     /* define if splines vertical advection */
#define TS_C4VADVECTION    /* define if 4th-order centered vertical advection */
#undef  TS_SMAGORINSKY     /* define if Smagorinsky-like diffusion */

#undef MIX_GEO_TS         /* mixing on geopotential (constant Z) surfaces */
#define MIX_S_UV           /* mixing along constant S-surfaces */
#undef MIX_S_TS
#undef MIX_GEO_UV         /* mixing on geopotential (constant Z) surfaces */
#define MIX_ISO_TS

#define LIMIT_BSTRESS      /* limit bottom stress */
#define LIMIT_ICESTRESS    /* limit ice shelf basal stress */

#define SALINITY           /* define if using salinity */
#define SOLVE3D            /* define if solving 3D primitive equations */
#undef  BODYFORCE          /* define if applying stresses as bodyforces */
#define RI_SPLINES
#define MASKING            /* define if there is land in the domain */
#define AVERAGES           /* define if writing out time-averaged data */
#undef  AVERAGES_DETIDE    /*use if writing out NLM time-averaged detided fields*/
#undef  AVERAGES_AKT       /*undef Frode, define if writing out time-averaged AKt*/
#undef  AVERAGES_AKS       /*undef Frode, define if writing out time-averaged AKs*/
#undef  AVERAGES_AKV       /* define if writing out time-averaged AKv */

#undef  STATIONS           /* define if writing out station data */
#undef  STATIONS_CGRID     /* define if extracting data at native C-grid */

#undef  BVF_MIXING         /* define if Brunt_Vaisala frequency mixing */
#define LMD_MIXING         /* define if Large et al. (1994) interior closure */
#undef  MY25_MIXING        /* define if Mellor/Yamada level-2.5 mixing */
#undef GLS_MIXING         /* Activate Generic Length-Scale mixing */

#ifdef GLS_MIXING
# define N2S2_HORAVG       /* Activate horizontal smoothing of buoyancy/shear */
#endif
#ifdef LMD_MIXING
# define LMD_BKPP          /* use if bottom boundary layer KPP mixing */
# define LMD_CONVEC        /* use to add convective mixing due to shear instability */
# define LMD_DDMIX         /* use to add double-diffusive mixing */
# undef LMD_NONLOCAL      /* use if nonlocal transport */
# define LMD_RIMIX         /* use to add diffusivity due to shear instability */
# undef LMD_SHAPIRO       /* use if Shapiro filtering boundary layer depth */
# define LMD_SKPP          /* use if surface boundary layer KPP mixing */
#endif

#define ANA_BSFLUX         /* analytical bottom salinity flux */
#define ANA_BTFLUX         /* analytical bottom temperature flux */
#undef  ANA_GRID           /* analytical grid set-up */
#undef  ANA_INITIAL        /* analytical initial conditions */
#undef  ANA_MASK           /* analytical land/sea masking */
#undef  ANA_MEANRHO         
#undef  ANA_SSFLUX         /* analytical surface salinity flux */
#undef  ANA_STFLUX         /* analytical surface temperature flux */
#undef  ANA_SMFLUX         /* analytical surface momentum stress */

#define ANA_SPONGE         /* sponge layer at open boundary */

/* CLIMATOLOGY */
#undef M2CLIMATOLOGY      /* define 2D momentum climatology */
#undef M3CLIMATOLOGY      /* define 3D momentum climatology */
#undef TCLIMATOLOGY       /* define tracers climatology */
#undef  M2CLM_NUDGING
#undef M3CLM_NUDGING      /* nudging 3D momentum climatology */
#undef TCLM_NUDGING       /* nudging tracers climatology */
#undef OBC_NUDGING

#undef  WRF_COUPLING       /* coupling to WRF atmospheric model */

/* ATMOSPHERIC FORCING */
#define BULK_FLUXES        /* turn ON or OFF bulk fluxes computation */
#ifdef  BULK_FLUXES
# undef ANA_RAIN          /* analytical rain fall rate */
# undef ANA_PAIR          /* analytical surface air pressure */
# undef  ANA_HUMIDITY      /* analytical surface air humidity */
# undef  ANA_CLOUD         /* analytical cloud fraction */
# undef ANA_TAIR          /* analytical surface air temperature */
# undef ANA_WINDS         /* analytical surface winds */
# define ICEBERGS         /* freshwater fluxes from iceberg melt */
# define PRECIP_NOINTERP  /* don't interpolate ECMWF precipitation in time */
# define SEPARATE_EVAP    /* read evaporation, separate to precipitation */
# undef  EMINUSP           /* turn ON internal calculation of E-P */
# define ANA_SRFLUX        /* analytical surface shortwave radiation flux */
# define ALBEDO            /* use albedo equation for shortwave radiation */
# undef  CLOUDS      
# undef  LONGWAVE_OUT      /* compute outgoing longwave radiation */
# define  LONGWAVE          /* Compute net longwave radiation internally */
# define COOL_SKIN         /* turn ON or OFF cool skin correction */
# undef  SHORTWAVE
#endif

#undef ATM_PRESS          /* use to impose atmospheric pressure onto sea surface */
#undef SOLAR_SOURCE       /* define solar radiation source term */

/* TIDES */
#undef POT_TIDES         /* Potential tides by Kate Edstrom */
#undef SSH_TIDES          /* turn on computation of tidal elevation, default define */
#undef UV_TIDES           /* turn on computation of tidal currents */
#undef ADD_FSOBC          /* Add tidal elevation to processed OBC data, default define */
#undef ADD_M2OBC          /* Add tidal currents  to processed OBC data */
#undef ADD_FS_INV_BARO
#undef RAMP_TIDES         /* Spin up tidal forcing */

/* ICESHELF */
#define ICESHELF
#define ICESHELF_3EQN_VBC
#undef ICESHELF_MORPH


/* ELVER */
#undef UV_PSOURCE         /* turn ON or OFF point Sources/Sinks */
#undef TS_PSOURCE         /* turn ON or OFF point Sources/Sinks */
/* --------------------------- */



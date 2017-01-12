# metroms-iceshelf
Kaitlin's additions to metroms:
-Ice shelves (from Ben Galton-Fenzi, option ICESHELF)
-Potential tides (from Kate Hedstrom, option POT_TIDES)
-Flux limiters for TS_U3HADVECTION (from Gary Brassington and Frank Colberg, option UPWIND_LIMITER)
-Same computational grid coupled between ROMS and CICE (no ghost cells passed, matters for periodic boundary conditions)
-Different frazil ice formation routine (to match POP)
-Freshwater flux from icebergs (option ICEBERGS)
-Non-interpolation of 12-hour ERA-Interim precipitation forcing (option PRECIP_NOINTERP)


########################################################################
# Python-modules:
########################################################################
import numpy as np
import os
import Constants
from datetime import datetime, timedelta
########################################################################
# METROMS-modules:
########################################################################
from GlobalParams import *
from Params import *
from ModelRun import *
########################################################################
########################################################################
# Set cpus for ROMS:
xcpu=32
ycpu=16
# Set cpus for CICE:
icecpu=96
# Choose a predefined ROMS-application:
app='circumpolar'

start_date = datetime(1992,01,01,00)
end_date   = datetime(2002,01,01,00)

# Initial run
#circparams=Params(app,xcpu,ycpu,start_date,end_date,nrrec=0,cicecpu=icecpu,restart=False)
# Restart run
circparams=Params(app,xcpu,ycpu,start_date,end_date,nrrec=-1,cicecpu=icecpu,restart=True)

modelrun=ModelRun(circparams)

modelrun.preprocess()
modelrun.run_roms(Constants.MPI,Constants.NODEBUG,Constants.RAIJIN)
modelrun.postprocess()


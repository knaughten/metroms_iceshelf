#!/bin/bash


#export METROMS_MYHOST=metlocal
#export METROMS_MYHOST=vilje
export METROMS_MYHOST=raijin

#export METROMS_MYARCH=Linux

if [ "$METROMS_MYHOST" == "metlocal" ]; then
    export METROMS_BASEDIR=/disk1/$USER
    export METROMS_TMPDIR=/disk1/$USER
elif [ "$METROMS_MYHOST" == "vilje" ]; then
    export METROMS_BASEDIR=$HOME
    export METROMS_TMPDIR=/work/$USER
elif [ "$METROMS_MYHOST" == "raijin" ]; then
    export METROMS_BASEDIR=/short/m68/kaa561/metroms_iceshelf
    export METROMS_TMPDIR=$METROMS_BASEDIR
else
    echo "Undefined METROMS_MYHOST ", $METROMS_MYHOST
fi


export PYTHONPATH=$PYTHONPATH:$METROMS_BASEDIR/apps/common/python/

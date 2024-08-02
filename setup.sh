#! /bin/bash

CURRENT_DIR=$(pwd)

cd WaveformAna
git pull
source setup.sh
cd $CURRENT_DIR

source py3/bin/activate

cd BetaScope-DAQ
git pull
cd ..
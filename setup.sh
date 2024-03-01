#! /bin/bash

cd WaveformAna
git pull
source setup.sh
cd ..
source py3/bin/activate

cd BetaScope-DAQ
git pull
cd ..
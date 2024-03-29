# SSRL 2024 X-rays beam test for Low Gain Avalanche Detectors (LGADs)
LGAD X-rays Test Beam at SSRL (2024). The repository is for documenting related software and analysis codes for the 2024 SSRL beam test.

Data conversion, scripts for analsys routines and methods, and logbook infomation can be found here.

Logbook and shift schedule can be found here: [2024_SSRL_run](https://drive.google.com/drive/folders/1eRdXsyAIbnhs2xJvsL8nBAKjm6VIcOl0?usp=sharing)

Beam test data will be stored on the UFSD NAS:
 + raw data: `/volume1/SSRL_2024/`
 + ntuples: `/volume1/SSRL_2024_ntuples/`

The conversion `JSON` for `h5` to `ROOT` is now in `/configs/real_jobs.json`

# Updates (2024/03/01)

Data conversion is happening. data from `20224/02/29` can be found on the NAS `/volume1/SSRL_2024_ntuples/`

# Tools and analysis packages

- Data convertion and prep [BetaScope-DAQ](https://github.com/neko-0/BetaScope-DAQ): `https://github.com/neko-0/BetaScope-DAQ`
- Waveoform analysis [WaveformAna](https://github.com/neko-0/WaveformAna): `https://github.com/neko-0/WaveformAna`
- Histogram, energy extraction, fits etc `pyssrl`:
    - requires package [collinearw](https://gitlab.cern.ch/scipp/collinear-w/collinearw) : `https://gitlab.cern.ch/scipp/collinear-w/collinearw`

## Manual installation

### Installing waveform analysis
```bash
git clone https://github.com/neko-0/WaveformAna
cd WaveformAna
source setup.sh
```
if set up is finished correctly, simply compile the codes with typing `build`.
Every time if there is change to the source file, you need to type `build` to recompile.

### Installing python pakcages
First create a virtual environment via `python -m venv py3`, then `source py3/bin/activate`. Un-tar and install the `collinearw` package:

```bash
mkdir collinearw
tar xf collinearw.tar.gz -C collinearw --strip-components=1
cd collinearw
python -m pip install -e .
```

## Docker image
The `Dockerfile` is provided to build the environment for waveform analysis, to build the image

```bash
docker build -t ufsd_ssrl:1.0 .
```

If there is permission issue on `docker.sock`, try with:

```bash
sudo setfacl --modify user:$USER:rw /var/run/docker.sock
```

Then it should be available via (with mouting home directory)

```bash
docker run -it -v $HOME:$HOME ufsd_ssrl:1.0
```

# Setup enviornment

To setup the commandlines alias and working python environment

## On docker
After login or inside docker, run the setup script: `source setup.sh`. 

## Manual setup
To setup the waveform alais from `WaveformAna` and activate the python virtual environment

```bash
cd WaveformAna
source setup.sh
cd ..
source py3/bin/activate
```

# Manuals and instructions
- [data conversion](manuals/data_conversion.md): converting scope data to ROOT format.
- [waveform analysis](manuals/waveform_analysis.md): analysis routines for waveform.
- [post-processing](manuals/postprocessing.md): histograming, extracting energy, plots, etc.
- [toy MC for Compton scattering](manuals/compton.md): generate compton cross-section with toy MC.
- [GEANT sim](manuals/geant.md): geant simulation for LGADs and X-rays.
- [TCAD sim](manuals/tcad.md): tcad simulation related things and results.

## Post-processing (Histogram, plots, etc)

The `pyssrl` (TODO upload) package is used for post-processing and histograming steps. The padckage is built from the collinear W+jets package ([collinearw](https://gitlab.cern.ch/scipp/collinear-w/collinearw)), with dedicated custom filling routine and objects for the `SSRL`.


## Toy Monte Carlo for Compton scattering.

TODO

## GEANT simulation for X-rays and LGAD related thing.

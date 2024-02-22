# SSRL 2024 X-rays beam test for Low Gain Avalanche Detectors (LGADs)
LGAD X-rays Test Beam at SSRL (2024). The repository is for documenting related software and analysis codes for the 2024 SSRL beam test.

Data conversion, scripts for analsys routines and methods, and logbook infomation can be found here.

Logbook and shift schedule can be found here: [2024_SSRL_run](https://drive.google.com/drive/folders/1eRdXsyAIbnhs2xJvsL8nBAKjm6VIcOl0?usp=sharing)

Beam test data will be stored on the UFSD NAS. 

Softwares and analysis pacakges are basically the same as the previous SSRL test beam.

# Tools and analysis packages

- Data convertion and prep [BetaScope-DAQ](https://github.com/neko-0/BetaScope-DAQ): `https://github.com/neko-0/BetaScope-DAQ`
- Waveoform analysis [WaveformAna](https://github.com/neko-0/WaveformAna): `https://github.com/neko-0/WaveformAna`
- Histogram, pltos, fits etc `pyssrl`:
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

Then it should be available via (TODO: mount point etc)

```bash
docker run -it ufsd_ssrl:1.0
```

# Setup enviornment
After login or inside docker, run the following setup steps:

```bash
cd WaveformAna
source setup.sh
cd ..
source py3/bin/activate
```
# Manuals
- [data conversion](manuals/data_conversion.md) 
- [waveform analysis](manuals/waveform_analysis.md)

## Post-processing (Histogram, plots, etc)

The `pyssrl` (TODO upload) package is used for post-processing and histograming steps. The padckage is built from the collinear W+jets package ([collinearw](https://gitlab.cern.ch/scipp/collinear-w/collinearw)), with dedicated custom filling routine and objects for the `SSRL`.


## Toy Monte Carlo for Compton scattering.

TODO

## GEANT simulation for X-rays and LGAD related thing.

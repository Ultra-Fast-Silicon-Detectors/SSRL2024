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

# Converting scope data (H5) format to ROOT format

The `hdf5_to_root.py` convertor from `BetaScope-DAQ` is used to convert scope data to usual ROOT format:

```bash
python ~/BetaScope-DAQ/daq_runners/hdf5_to_root.py \
    --directory h5_file_source_directory \
    --prefix Run8_HPK_3p1_200V_35KeV_baselineE \ 
    --channels 3,4 \
    --mode scope \
    --start 1 \
    --use-mp \
    --format 1 
```

where the flags are:
- `--mode scope` for single set of data conversion. batch version see below.
- `--start 1` the first index of the data, e.g. `xxx_ch3_000001.h5`.
- `--prefix xxx` the prefix of the file. e.g. `xxx_ch4_000001.h5`.
- `use-mp` enable multiprocessing.
- `--channels 3,4` saved channels.Use comma to separate channels.
- `--format 1` format on how to identify file name pattern.

Note on the `--format`, there are 3 different patterns, assuming file prefix with `xxx` and channel `N`:
- Mode `0` is for `xxx_chN00001.h5` pattern.
- Mode `1` is for `xxx00001_chN.h5` pattern.
- Mode `2` is for `xxx00001.h5` pattern. Channel doesn't matter in this case, so just specify any single number and it will be used as branch name.

Other pattern can be easily implement, but it's best to keep the data naming pattern consistent during the beam test.

The conversion jobs can be specified in a `JSON` file for batch jobs. An example of `JSON` file is the following (`jobs.json`):

```JSON
{
    "HPK3p2" : [
        {
            "prefix" : "Run56_HPK_3p2_100V_35KeV_baselineE",
            "channels" : [3],
            "start_findex" : 1,
            "output" : "HPK3p2",
            "format" : 2,
            "merge" : false,
            "use_mp" : true
        },

        {
            "prefix" : "Run58_HPK_3p2_130V_35KeV_baselineE",
            "channels" : [3],
            "start_findex" : 1,
            "output" : "HPK3p2",
            "format" : 2,
            "merge" : false,
            "use_mp" : true
        }
    ],

    "BNL20um" : [
        {
            "prefix" : "Run100_BNL20um_100V_10keV_Att0p1percAT8p5kev",
            "channels" : [3],
            "start_findex" : 1,
            "output" : "BNL20um",
            "format" : 0,
            "merge" : false,
            "use_mp" : true
        },

        {
            "prefix" : "Run64_BNL20um_80V_baselineE",
            "channels" : [3],
            "start_findex" : 1,
            "output" : "BNL20um",
            "format" : 0,
            "merge" : false,
            "use_mp" : true
        }
    ]
}
```

Then, to submit jobs from the `JSON` file via:

```bash
python ~/BetaScope-DAQ/daq_runners/hdf5_to_root.py --mode scope-batch --joblist jobs.json --jobname "HPK3p2,BNL20um" 
```

# Waveform analysis

## Running waveform analysis

After setting up the analysis tools, commandline interface should be avaible.

For standard scope data (non-digitizer runs), the SSRL routine can be used to perform waveform analysis:

```bash
run_Ana --selector SSRL --directory path_to_raw_wavforms_root_files --config config.yaml
```

The `--selector` picks the implemented analysis routine. There are also other quick analysis routine to perform simple check during the beam test (TODO). The `config.yaml` fine tune the metthods and setting for the `SSRL` analysis routine, e.g. baseline correction etc.

## Post-processing (Histogram, plots, etc)

The `pyssrl` (TODO upload) package is used for post-processing and histograming steps. The padckage is built from the collinear W+jets package ([collinearw](https://gitlab.cern.ch/scipp/collinear-w/collinearw)), with dedicated custom filling routine and objects for the `SSRL`.


## Toy Monte Carlo for Compton scattering.

TODO

## GEANT simulation for X-rays and LGAD related thing.


# Converting scope data (H5) format to ROOT format

The `hdf5_to_root.py` convertor from `BetaScope-DAQ` is used to convert
scope data to usual ROOT format:

``` bash
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

- `--mode scope` for single set of data conversion. batch version see
  below.
- `--start 1` the first index of the data, e.g. `xxx_ch3_000001.h5`.
- `--prefix xxx` the prefix of the file. e.g. `xxx_ch4_000001.h5`.
- `--use-mp` enable multiprocessing.
- `--channels 3,4` saved channels.Use comma to separate channels.
- `--format 1` format on how to identify file name pattern.

Note on the `--format`, there are 3 different patterns, assuming file
prefix with `xxx` and channel `N`:

- Format `0` is for `xxx_chN00001.h5` pattern.
- Format `1` is for `xxx00001_chN.h5` pattern.
- Format `2` is for `xxx00001.h5` pattern. Channel doesn’t matter in
  this case, so just specify any single number and it will be used as
  branch name.
- Format `3` is for `xxx_chN.h5` pattern. No file indexing in this
  format.

Other pattern can be easily implement, but it’s best to keep the data
naming pattern consistent during the beam test.

The conversion jobs can be specified in a `JSON` file for batch jobs. An
example of `JSON` file is the following (`jobs.json`):

``` json
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

``` bash
python ~/BetaScope-DAQ/daq_runners/hdf5_to_root.py --mode scope-batch --joblist jobs.json --jobname "HPK3p2,BNL20um" 
```

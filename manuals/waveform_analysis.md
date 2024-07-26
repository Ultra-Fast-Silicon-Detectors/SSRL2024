
# Waveform analysis

## Running waveform analysis

After setting up the analysis tools, commandline interface should be
avaible.

For standard scope data (non-digitizer runs), the SSRL routine can be
used to perform waveform analysis:

``` bash
run_Ana --selector SSRL --directory path_to_raw_wavforms_root_files --config ssrl_ana_config.yaml
```

The `--selector` picks the implemented analysis routine. There are also
other quick analysis routine to perform simple check during the beam
test (TODO). The `ssrl_ana_config.yaml` fine tune the metthods and
setting for the `SSRL` analysis routine, e.g. baseline correction etc.

The `ssrl_ana_config.yaml` contains the following:

``` yaml
general:
  store_waveform: true
  use_single_t_trace: true
  use_single_input_t_trace: true
  nchannels: 16
  # opt 1: ARPLS PLS, opt 2: noise-median filter
  baseline_opt: 1
  run_type: 1
  do_max_ch: false
  threshold: 0
  trigger_ch: -1
  invert_ch: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
  simple_ana_ch: [-1]
  # opt 1: regular scope routine, opt 2: CAEN scan routine
  routine: 2

# this control the fix time window search for pmax and tmax
# bunch_start: 
#   starting time for the 1st bunch
# bunch_step_size: 
#   size of the bunch spacing. 
#   The 1st search window would be [bunch_start, bunch_start+bunch_step_size]
# bunch_nstep:
#   number of bunch search windows
# bunch_edge_dist:
#   just set it to zero for now.
bunch_window:
  bunch_start: 240
  bunch_step_size: 10
  bunch_nstep: 50
  bunch_edge_dist: 0

leading_signal:
  tmin: -150.0
  tmax: 50.0
```

## Running quick heatmap for scan runs

Heatmap of pmax can be quickly generated for scan runs with the
following:

``` bash
run_Ana --selector QuickScan --directory <path_to_scan_root_files> --config </configs/heatmap.yaml>
```


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

    general:
      store_waveform: true
      use_single_t_trace: false
      use_single_input_t_trace: false
      nchannels: 4
      baseline_opt: 1 # opt 1: , opt 2: median filter
      run_type: 1
      do_max_ch: false
      threshold: 0

    buckets:
      bucket_t_start: -44e-9
      bucket_t_end: 2.08e-9
      nbuckets: 28

    fix_window:
      fill_fix_window: true
      fix_win_start: -44e-9
      fix_win_step_size: 2.08e-9
      fix_win_nstep: 28

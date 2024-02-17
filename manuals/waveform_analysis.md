# Waveform analysis

## Running waveform analysis

After setting up the analysis tools, commandline interface should be avaible.

For standard scope data (non-digitizer runs), the SSRL routine can be used to perform waveform analysis:

```bash
run_Ana --selector SSRL --directory path_to_raw_wavforms_root_files --config ssrl_ana_config.yaml
```

The `--selector` picks the implemented analysis routine. There are also other quick analysis routine to perform simple check during the beam test (TODO). The `ssrl_ana_config.yaml` fine tune the metthods and setting for the `SSRL` analysis routine, e.g. baseline correction etc.

The `ssrl_ana_config.yaml` contains the following:

```{r results="asis"}
cat(readLines('../configs/ssrl_ana_config.yaml'), sep = '\n')
```

```{r comment=''}
cat(readLines('data_conversion.md'), sep = '\n')
```

.PHONY: all
all: out/fig_rates.pdf

## Prepare data

out/lfp_raw.rds: src/lfp_raw.R \
  data/HLF000701_20241217_025207_52.csv \
  data/HLF432701_20241217_024139_51.csv
	Rscript $^ $@

out/lfp.rds: src/lfp.R \
  out/lfp_raw.rds
	Rscript $^ $@


## Model and forecast

out/mod.rds: src/mod.R \
  out/lfp.rds
	Rscript $^ $@

out/forecast.rds: src/forecast.R \
  out/mod.rds
	Rscript $^ $@


## Figures

out/fig_rates.pdf: src/fig_rates.R \
  out/forecast.rds
	Rscript $^ $@



## Clean

.PHONY: clean
clean:
	rm -rf out
	mkdir out

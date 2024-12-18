
suppressPackageStartupMessages({
  library(dplyr)
  library(command)
})

cmd_assign(lfp_raw = "out/lfp_raw.rds",
           .out = "out/lfp.rds")

lfp <- lfp_raw |>
  mutate(n_eff = (rate * (1 - rate)) / (se^2),
         x_eff = n_eff * rate)

saveRDS(lfp, file = .out)





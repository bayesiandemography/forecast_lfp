
suppressPackageStartupMessages({
  library(bage)
  library(command)
})

cmd_assign(lfp = "out/lfp.rds",
           .out = "out/mod.rds")

mod <- mod_binom(x_eff ~ age:sex + age:sex:time + age:time,
                 data = lfp,
                 size = n_eff) |>
  set_prior(age:time ~ RW_Seas(n_seas = 4, sd = 0)) |>
  set_prior(age:sex:time ~ SVD_RW2(LFP, sd = 0)) |>
  fit()

print(mod)

saveRDS(mod, file = .out)





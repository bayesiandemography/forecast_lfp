
suppressPackageStartupMessages({
  library(bage)
  library(dplyr)
  library(command)
})

cmd_assign(mod = "out/mod.rds",
           .out = "out/forecast.rds")

labels <- seq.Date(from = as.Date("2024-10-01"),
                   to = as.Date("2040-10-01"),
                   by = "quarter")

forecast <- mod |>
  forecast(labels = labels,
           include_estimates = TRUE) |>
  mutate(draws_ci(.fitted))

saveRDS(forecast, file = .out)

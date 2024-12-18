
suppressPackageStartupMessages({
  library(readr)
  library(tidyr)
  library(dplyr)
  library(poputils)
  library(command)
})

cmd_assign(.rate = "data/HLF000701_20241217_025207_52.csv",
           .se = "data/HLF432701_20241217_024139_51.csv",
           .out = "out/lfp_raw.rds")

age_labels <- age_labels(type = "five", min = 15, max = 65, open = TRUE)
col_names <- c("time",
               paste(rep(c("Male", "Female"), each = length(age_labels)),
                     age_labels,
                     sep = "."))
col_types <- paste0("c", paste(rep("d", times = 2 * length(age_labels)), collapse = ""))

rate <- read_csv(.rate,
                 col_names = col_names,
                 col_types = col_types,
                 skip = 4,
                 n_max = 155) |>
  pivot_longer(-time, names_to = "sex.age", values_to = "rate") |>
  separate_wider_delim(sex.age, delim = ".", names = c("sex", "age"))

se <- read_csv(.se,
               col_names = col_names,
               col_types = col_types,
               skip = 5,
               n_max = 138) |>
  pivot_longer(-time, names_to = "sex.age", values_to = "se") |>
  separate_wider_delim(sex.age, delim = ".", names = c("sex", "age"))

lfp_raw <- inner_join(rate, se, by = c("age", "sex", "time")) |>
  mutate(time = sub("Q1", "-01-01", time),
         time = sub("Q2", "-04-01", time),
         time = sub("Q3", "-07-01", time),
         time = sub("Q4", "-10-01", time),
         time = as.Date(time)) |>
  mutate(rate = rate / 100,
         se = se / 100)

saveRDS(lfp_raw, file = .out)





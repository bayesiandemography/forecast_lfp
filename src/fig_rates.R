
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(command)
})

cmd_assign(forecast = "out/forecast.rds",
           .out = "out/fig_rates.pdf")

labels <- seq.Date(from = as.Date("2024-10-01"),
                   to = as.Date("2040-10-01"),
                   by = "quarter")

p <- ggplot(forecast, aes(x = time)) +
  facet_wrap(vars(age)) +
  geom_ribbon(aes(ymin = .fitted.lower,
                  ymax = .fitted.upper,
                  fill = sex),
              alpha = 0.2) +
  geom_line(aes(y = .fitted.mid,,
                col = sex),
            linewidth = 0.5) +
  geom_point(aes(y = .observed),
             col = "black",
             size = 0.1)


graphics.off()
pdf(file = .out,
    w = 10,
    h = 8)
plot(p)
dev.off()

library(tidyverse)
library(readxl)
library(here)

path <- here::here("data/F1_Dataset.xlsx")

results <- read_excel(path, sheet = "results")

driver_table <- results %>%
  filter(!is.na(positionOrder), !is.na(grid), grid > 0) %>%
  group_by(driverId) %>%
  summarise(
    races = n(),
    avg_finish = mean(positionOrder, na.rm = TRUE),
    avg_start = mean(grid, na.rm = TRUE)
  ) %>%
  filter(races >= 50) %>%
  arrange(avg_finish) %>%
  slice_head(n = 5)

top5_ids <- driver_table %>%
  pull(driverId)

plot_top5 <- results %>%
  filter(driverId %in% top5_ids) %>%
  filter(!is.na(grid), !is.na(positionOrder), grid > 0)

p <- ggplot(plot_top5, aes(x = grid, y = positionOrder)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ driverId) +
  labs(
    title = "Starting vs Finishing Position for Top 5 Drivers",
    x = "Starting Position",
    y = "Finishing Position"
  ) +
  theme_minimal()

ggsave(
  filename = here::here("output/top5_figure.png"),
  plot = p,
  width = 10,
  height = 6
)
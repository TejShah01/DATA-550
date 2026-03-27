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
  slice_head(n = 10)

write_csv(driver_table, here::here("output/driver_table.csv"))
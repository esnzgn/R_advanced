
rm(list =  ls())

# =========================
# script Name: penguin.R
# purpose: analyze penguin dataset to cal mean flipper length and culmen ratios
# Author: Ehsan
# Data: 27.05.2025
# =========================

# loading packages ####
source("./script/req.R")
# library(dplyr)
# library(ggplot2)
# library(palmerpenguins)
# library(tidyr)

# data preparation ####
penguin_clean  <- janitor::clean_names(penguins_raw)

# data analysis based on mean ####
length_culmen_ratio <- penguin_clean %>% 
  select(species, island, culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>% 
  drop_na(culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>% 
  mutate(culmen_ratio = culmen_length_mm / culmen_depth_mm) %>% 
  group_by(species, island) %>% 
  summarise(mean_flipper_length = mean(flipper_length_mm),
            mean_culmen_ratio = mean(culmen_ratio)) %>% 
  arrange(species, island)

# data analysis based on median ####




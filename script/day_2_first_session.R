

library(palmerpenguins)

mean(penguins$body_mass_g, na.rm = T)

library(dplyr)

penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  group_by(species) %>% 
  summarise(avg_mass = mean(body_mass_g))


penguins %>% 
  select(species, bill_length_mm, body_mass_g)


unique(penguins$island)

penguins %>% 
  filter(flipper_length_mm > 200) %>%
  group_by(island) %>% 
  summarise(mean_mass = mean(body_mass_g))


# filter out the missing values
# create a new col mass_kg
# dividing by 1000 
# find the heavist penguine in each species













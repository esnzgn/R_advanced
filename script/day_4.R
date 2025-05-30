
plot <- penguins %>% 
          drop_na(sex) %>% 
          ggplot(aes(x = species, y = flipper_length_mm, fill = species)) +
          geom_violin(width = 0.5, alpha = 0.4) +
          geom_boxplot(width = 0.2) +
          scale_fill_brewer(palette = "Dark2")


plot


source("./script/custom_theme.R")

plot +
  ggtitle("Comparison of flipper vs bodymass\n by species in Penguin dataset") +
  labs(x = "", y = "flipper length (mm)") +
  theme_custom(base_size = 12, base_family = "serif")


my_palette <- c("#534F4A", "#887060", "#A89384", "#DAE8EA", "#5AD8F4", "#158BBB")

ggplot(penguins, aes(x = species, fill = species)) +
  geom_bar() +
  scale_fill_manual(values = my_palette[c(1,3,5)])
  

# 
penguins %>% 
  ggplot(aes(x = species, y = flipper_length_mm, fill = species)) +
  stat_halfeye(justification = -0.2, .width = 0, point_colour = NA) +
  geom_boxplot(width = 0.3, alpha = 0.4, outlier.shape = NA) +
  stat_dots(side = "left", justification = 1.1, dotsize = 0.2) +
  coord_flip()
  
  # highest density plot region
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = species, fill = species)) +
  geom_point(alpha = 0.2) +
  geom_hdr_lines()

#
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = species, fill = species)) +
  geom_density_ridges(alpha = 0.8)
  

# coloringpenguins %>% 
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm)) +
  geom_histogram(
    bins = 50,
    aes(y = ..density.. , fill = species),
    position = "identity",
    colour = "black"
  )

pal <- c("Adelie" = "#5AD4F6", "Gentoo" = "darkgreen", "Chinstrap" = "#887060")

penguins %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species)) +
  scale_color_manual(values = pal) +
  theme_minimal()


penguins %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm", level = .85) +
  scale_color_brewer(palette = "Set1")

# tables ####
penguine_counts <- penguins %>% 
  drop_na(sex) %>% 
  mutate(year = as.character(year),
         sex = str_to_lower(sex)) %>% 
  group_by(species, island, sex, year) %>% 
  summarise(n = n(), .groups = "drop")

penguine_counts_wider <- penguine_counts %>% 
  pivot_wider(
    names_from = c(species, sex),
    values_from = n
  ) %>% 
  mutate(across(-(1:2), ~replace_na(., 0))) %>% 
  arrange(island, year)

penguine_counts_wider %>% 
  gt()

gt_tbl <- penguine_counts_wider %>% 
  gt() %>% 
  cols_label(
    island = "Island",
    year = "Year", 
    Adelie_female = "Adelie (female)", 
    Adelie_male  = "Adelie (male)",
    Chinstrap_female = "Chinstrap (female)",
    Chinstrap_male  = "Chinstrap (male)",
    Gentoo_female = "Gentoo (female)",
    Gentoo_male = "Gentoo (female)"
  )

gt_tbl %>% 
  tab_spanner("**Adelie**", columns = 3:4) %>% 
  tab_spanner("**Chinstrap**", columns = 5:6) %>% 
  tab_spanner("**Gentoo**", columns = 7:8)

desired_colnames <- colnames(penguine_counts_wider) %>% 
  str_remove("(Adelie|Gentoo|Chinstrap)_") %>% 
  str_to_title()

names(desired_colnames) <- names(penguine_counts_wider)

penguine_counts_wider %>% 
  gt() %>% 
  cols_label(.list = desired_colnames) %>% 
  tab_spanner("**Adelie**", columns = 3:4) %>% 
  tab_spanner("**Chinstrap**", columns = 5:6) %>% 
  tab_spanner("**Gentoo**", columns = 7:8) %>% 
  tab_header(
    title = "Penguine of the Palmer",
    subtitle = "Data from the palmerpenguins package"
  )


source("./script/req.R")

penguins_clean <- penguins |> drop_na()

map(.x = penguins_clean, .f = mean)


numeric_cols <- penguins_clean |> 
  select(where(is.numeric))

map_dbl(numeric_cols, mean)


map_int(numeric_cols, ~ round(mean(.x, na.rm = TRUE)))

map_dbl(numeric_cols, ~ mean(.x, na.rm = TRUE))


nested_penguins <- penguins_clean |> 
  nest(data = -species)

nested_heavy <- nested_penguins |> 
  mutate(heavier = map(data, ~ .x |> 
                         filter(body_mass_g > mean(body_mass_g, na.rm = TRUE))))


# Plot for each species
plots_df <- nested_heavy |> 
  mutate(plot = map(heavier, ~ 
                      ggplot(.x, aes(x = flipper_length_mm, y = body_mass_g)) +
                      geom_point()
  ))

#  to view them
# library(patchwork)
wrap_plots(plots_df$plot)

walk(walk(plots_df$plot, print))

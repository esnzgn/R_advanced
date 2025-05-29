
source("./script/req.R")

penguins_clean <- penguins |> drop_na()

map(.x = penguins_clean, .f = mean)


numeric_cols <- penguins_clean |> 
  select(where(is.numeric))

map_dbl(numeric_cols, mean)

map_int(numeric_cols, ~ round(mean(.x, na.rm = TRUE)))

map_dbl(numeric_cols, ~ mean(.x, na.rm = TRUE))

row_means_for <- function(df) {
  means <- numeric(nrow(df))
  for (i in seq_len(nrow(df))) {
    means[i] <- mean(as.numeric(df[i, ]), na.rm = TRUE)
  }
  return(means)
}
# apply
# do a benchmark for the above different maps and also 
res_micro_bench <- microbenchmark(
  apply = apply(numeric_cols, 1, mean, na.rm = TRUE),
  map_dbl = map_dbl(numeric_cols, mean),
  map_int = map_int(numeric_cols, ~ round(mean(.x, na.rm = TRUE))),
  map_dbl_na_rm = map_dbl(numeric_cols, ~ mean(.x, na.rm = TRUE)),
  internal_for = row_means_for(numeric_cols),
  times = 10
)


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

walk(plots_df$plot, print)



# second part of 3rd day 
# timing for effcieny 
start <- Sys.time()
global()
Sys.time() - start

res <- numeric()
for (i in 1:1000) res[i] <- mean(rnorm(100))

res <- numeric(1000)
for (i in 1:1000) res[i] <- mean(rnorm(100))

x <- 1:1000000
global <- function() sum(x)
local <- function() { y <- 1:1000000
                        ab <- sum(y)
                        zy <- ab * 10 }

res_micro_bench <- microbenchmark(global(), local(), times = 10000)



slow <- function(x) sum(x / length(x)) 
fast <- cmpfun(slow)
res_micro_bench <- microbenchmark(slow(x), fast(x), mean(x))

df <- as.data.frame(res_micro_bench)
df$time_ms <- df$time / 1e6  # Convert nanoseconds to milliseconds

# Boxplot grouped by method
boxplot(time_ms ~ expr,
        data = df,
        log = "y",  # log-scale helps if values differ greatly
        main = "Microbenchmark Execution Time",
        ylab = "Execution Time (milliseconds)",
        xlab = "Funcitons",
        col = "lightblue")


# profile with profvis
# library(profvis)
profvis({ sum(rnorm(1e7))})

# catching
result <- NULL
my_fun <- function(data) {
  if (!is.null(result)) return(result)
  result <<- mean(data); result
}

# saving data to the disk
saveRDS(penguins, "./data/data.RDS")
readRDS("./data/data.RDS")


# data structures
df <- data.frame(col1 = rnorm(1e6), col2 = rnorm(1e6))

matrix_data <- matrix(c(rnorm(1e6), rnorm(1e6)), ncol = 2)

# benchmark
microbenchmark(
  colMeans(df),
  colMeans(matrix_data)
)

df_mixed <- data.frame(col1 = 1:1000, col2 = rep(letters, length.out = 1000))
list_mixed <- list(col1 = 1:1000, col2 = rep(letters, length.out = 1000))

microbenchmark(
  df_mixed$col1,
  list_mixed[[1]]
)

# as.list()
# creat df of penguine
df_penguins <- (penguins)
list_penguins <- as.list(df_penguins)

microbenchmark(
  df_penguins$bill_length_mm,
  list_penguins[["bill_length_mm"]]
)

# read I/O ####
# read.csv
# fread
# read_csv

# library(data.table)
# library(readr)
csv_name <- "./data/Bird_Dataset_All.csv"
read.table.timing <- system.time(read.table(csv_name, header = T, sep = ","))
reader.timing    <-  system.time(read_delim(csv_name, col_names = T, delim = ","))
data.tale.timing <-  system.time(allData <- fread(csv_name, showProgress = F))

data.frame(method = c("read.table", "readr", "fread"),
           timing = c(read.table.timing[3], reader.timing[3], data.tale.timing[3]))


allData_subsetted_by_fread <- fread(csv_name,
                           select = c("Year", "Species", "Urban"), showProgress = F)


# Tidy 
# library(tidyverse)
glimpse(penguins)

penguin_id <- c("P1", "P2", "P3")
wk1 <- c(2, 3, 1)
wk2 <- c(4, 1, 2)
wk3 <- c(3, 2, 4)

View(peng_obs) <- tibble(penguin_id, wk1, wk2, wk3)
print(peng_obs)

peng_obs_tidy <- peng_obs |>
                  pivot_longer(cols = wk1:wk3,
                               names_to = "week",
                               values_to = "observations")

print(peng_obs_tidy)

# using pen dataset identify which cols represent variables and which rows 
# represent observations?
bill_2019 <- c(39.1, 39.5, 40.3)
bill_2020 <- c(38.7, 41.1, 39.9)
bill_2021 <- c(40.6, 38.9, 41.2)

bill_data   <-   tibble(penguin_id = c("P1", "P2", "P3"),
                     bill_2019, bill_2020, bill_2021)

# pivot to long format ####
bill_long <- bill_data %>% 
  pivot_longer(
    cols = starts_with("bill_"),
    names_to = "year",
    values_to = "bill_length"
  )

penguins %>% 
  select(bill_length_mm, bill_depth_mm)
  
penguins %>% 
  rename(pen_bill_size = bill_length_mm)
  
# starts_with(); ends_with(); contains()
penguins |> 
  select(island, ends_with("_mm"), everything())

bill_ave <- mean(penguins$bill_length_mm, na.rm = T)


penguins %>% 
  filter(species == "Adelie", bill_length_mm < 43)
  
penguins %>% 
  filter(if_any(contains("bill"), ~ . < 40))


penguins %>% 
  filter(between(bill_length_mm,  38, 42))

penguins %>% 
  mutate(bill_length_cm = (bill_length_mm / 10))


mean(penguins$body_mass_g, na.rm = T)

penguins %>% 
  mutate(mass_class = case_when(
    body_mass_g > 5000 ~ "Heavy",
    body_mass_g > 3500 ~ "Medium",
    TRUE ~ "Light"
  )) %>% 
  View()

# data("penguins")

# rewrite it using tidy funcs
# base R code
desired_ids <- !grepl("sex", colnames(c))
new_penguins <- penguins[, desired_ids]
# tidy version
new_penguins <- penguins %>% 
  select(-contains("sex")) %>% 
  View()

penguins %>% 
  drop_na() %>% 
  mutate(bill_class = case_when(
    bill_length_mm > mean(penguins$bill_length_mm, na.rm = T) + 2 * sd(penguins$bill_length_mm, na.rm = T) ~ "very long",
    bill_length_mm > mean(penguins$bill_length_mm, na.rm = T) ~ "long",
    TRUE ~ "short"
  )) %>% 
  select(species, bill_length_mm, bill_class) %>% 
  View()

# pivot longer
penguins %>% 
  drop_na() %>% 
  pivot_longer(cols = contains("length"),
               names_to = "type_measure",
               values_to = "value_mm")


# pivot wider
penguins %>% 
  count(species, year) %>% 
  pivot_wider(names_from = year, values_from = n)

# separate
df <- tibble(id = c("2020_Gento", "2009_Adelie"))

df %>% 
  separate(id, into = c("year", "species"), sep = "_")

# unlist(strsplit(df$id, split = "_"))
  
penguins_mixed <- penguins %>% 
                    unite("island_species", island, species, sep = "_") 
penguins_mixed %>% 
  separate(island_species, into = c("places", "types"), sep = "_")  










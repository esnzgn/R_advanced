
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








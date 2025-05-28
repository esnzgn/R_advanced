
# Beyond R Programming - Day 2 Summary

## 📚 Table of Contents

1. [Packages Used](#packages-used)
2. [Dataset](#dataset)
3. [If-Else Statements](#1-if-else-statements)
4. [Apply Family](#2-apply-family)
5. [Mapping with Purrr](#3-mapping-with-purrr)
6. [Tidyr Functions](#4-tidyr-functions)
7. [Pipe Operator](#5-pipe-operator)
8. [Efficient Programming](#6-efficient-programming)
9. [Parallel Programming](#7-parallel-programming)
10. [Exercises](#8-exercises)

---

## Packages Used

```r
install.packages(c(
  "tidyverse", "palmerpenguins", "janitor", "dplyr", "tidyr",
  "purrr", "parallel", "doParallel", "foreach", "furrr", 
  "microbenchmark"
))
```

---

## Dataset

```r
library(palmerpenguins)
library(janitor)
penguins <- penguins %>% clean_names()
```

---

## 1. If-Else Statements

```r
# Basic usage
if (mean(penguins$body_mass_g, na.rm = TRUE) > 4000) {
  print("Average body mass is large")
} else {
  print("Average body mass is small")
}

# Using ifelse to categorize bill length
penguins$long_bill <- ifelse(penguins$bill_length_mm > 45, "Yes", "No")

# Multiple conditions with for loop
penguins$weight_category <- NA
for (i in seq_len(nrow(penguins))) {
  if (penguins$body_mass_g[i] > 4300) {
    penguins$weight_category[i] <- "heavy"
  } else if (penguins$body_mass_g[i] < 3500) {
    penguins$weight_category[i] <- "light"
  } else {
    penguins$weight_category[i] <- "medium"
  }
}
```

---

## 2. Apply Family

```r
# Summary statistics
apply(penguins[, sapply(penguins, is.numeric)], 2, mean, na.rm = TRUE)

# Create Z-scores
z_score <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
z_scores <- apply(penguins[, sapply(penguins, is.numeric)], 2, z_score)

# lapply example
lapply(penguins, class)

# sapply example
sapply(penguins, function(col) sum(is.na(col)))
```

---

## 3. Mapping with Purrr

```r
library(purrr)

# map() returns list
map(penguins, summary)

# map_dbl() returns numeric vector
map_dbl(penguins[, sapply(penguins, is.numeric)], mean, na.rm = TRUE)

# map with custom function
map_chr(penguins$species, ~ paste("Species:", .x))
```

---

## 4. Tidyr Functions

```r
library(tidyr)

# Pivot to longer
penguins_long <- penguins %>%
  pivot_longer(cols = starts_with("bill"), names_to = "bill_measure", values_to = "value")

# Pivot back to wide
penguins_wide <- penguins_long %>%
  pivot_wider(names_from = bill_measure, values_from = value)

# Unite columns
penguins <- penguins %>%
  unite("species_island", species, island, remove = FALSE)

# Separate columns
penguins <- penguins %>%
  separate(species_island, into = c("species2", "island2"), sep = "_")
```

---

## 5. Pipe Operator

```r
# Base version
mean(subset(penguins, species == "Adelie")$body_mass_g, na.rm = TRUE)

# Tidy version
penguins %>%
  filter(species == "Adelie") %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE))
```

---

## 6. Efficient Programming

```r
library(microbenchmark)

# Compare two methods
microbenchmark(
  base_loop = {
    result <- numeric(1000)
    for (i in 1:1000) result[i] <- sqrt(i)
  },
  vectorized = sqrt(1:1000)
)
```

---

## 7. Parallel Programming

```r
library(doParallel)
cl <- makeCluster(detectCores() - 1)
registerDoParallel(cl)

results <- foreach(i = 1:10) %dopar% {
  sqrt(i)
}
stopCluster(cl)
print(results)
```

---

## 8. Exercises

1. Create a column `mass_level` based on body mass thresholds using both `ifelse` and `mutate`.
2. Apply `z_score()` across numeric columns with `apply`.
3. Use `map_chr()` to label all penguins by species.
4. Convert the penguins data to long format and summarize per `bill_measure`.
5. Benchmark a loop vs. a vectorized operation using `microbenchmark`.
6. Use `foreach` to compute cube of numbers from 1 to 20 in parallel.




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
# hint use mutate to make a new col to while piping to next funciotn 
# find the heaviest penguin in each species
penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  mutate(mass_kg = body_mass_g / 1000) %>% 
  group_by(species) %>% 
  summarise(max_mass_kg = max(mass_kg))

# family of apply funcitons ####

source("./script/req.R")

data("penguins")

penguins_df <- penguins[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")]

df_list <- as.list(penguins_df)

lapply(df_list, mean, na.rm = T)

# ananymous func
lapply(df_list, function(x) x + 10)


add_value <- function(x, value) x + value 
lapply(df_list, add_value,  value = 100)

# sapply()
sapply(df_list, mean, na.rm = T)

# Compute column-wise means for all numeric columns
## first select the numeric columns (sapply)
numeric_col <- sapply(penguins, is.numeric)

## use lappply
numerical_means_lapply <- lapply(penguins[numeric_col], function(x) mean(x, na.rm = T))

## use sapply
numerical_means_sapply <- sapply(penguins[numeric_col], function(x) mean(x, na.rm = T))


# define a func that return a list of 3 statistics of mean, median, and SD
summary_stats <- function(x){
  list(
  mean = mean(x, na.rm = T),
  median = median(x, na.rm = T),
  sd = sd(x, na.rm = T)
  )
}

# lapply
custome_summary_lapply <- lapply(penguins[numeric_col], summary_stats)


# apply and multipe funciton calling 
num_data <- penguins[, sapply(penguins, is.numeric)]

result <- apply(num_data, 2, function(x){
  c(
  mean = mean(x, na.rm = T),
  median = median(x, na.rm = T),
  max = max(x, na.rm = T))
})

# excersie redo the same as a name funciton mean, median, max, SD

second_summary_stat <- function(x){
  c(mean = mean(x, na.rm = T),
    median = median(x, na.rm = T),
    max = max(x, na.rm = T),
    sd = sd(x, na.rm = T)
    )}

result_named_func <- apply(num_data, 2, second_summary_stat)

#  use the above fun in a row wise manner
result_named_func_row <- apply(num_data, 1, second_summary_stat)
View(t(result_named_func_row))

# using sapply  calculate mean of 3 last numerical col of penguine dataset
indx_col <- which(numeric_col)
col_last_three <- names(indx_col[3:5])
numerical_means_sapply <- sapply(penguins[,col_last_three], function(x) mean(x, na.rm = T))

# define a named func to compute the z-score for a numerical vector
z_score <- function(x){
  (x - mean(x, na.rm =T)) / sd(x, na.rm = T)
}
# then using apply fun use it column wise on numerical col of penguine dataset
penguins_clean <- na.omit(penguins[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g", "year")])

z_scores <- apply(penguins_clean, 2, z_score)

head(z_scores)

# mean absolute deviation (MAD) for each row of the excluded NAs Penguine dataset row wise
mad_fun <- function(x){
  mean(abs(x - mean(x, na.rm = T)), na.rm = T)
}

mad_score_pen <- apply(penguins_clean, 1, mad_fun)

if (condition){
  # codes -> in case the condition is T 
} else {
  # codes -> in case the condition is F
}

simple_penguine <- penguins_clean[1,]

if (simple_penguine$body_mass_g > 4300){
  print("heavy")
} else if (simple_penguine$body_mass_g < 3500) {
  print("super_light")
} else {
  print("medium")
}

# new column based on the above condition; penguins_clean
# for loop 
penguins_loop <- penguins_clean 

# a new col NA
penguins_loop$weight_class <- NA


sub_penguines_clean <- penguins_clean[1:10, c(1:3)]
dim(sub_penguines_clean)

for (i in 1:nrow(sub_penguines_clean)){
  print(i)
  # print(sub_penguines_clean$bill_length_mm[i])
  print("------ROWS------>")
  
  for (j in 1:ncol(sub_penguines_clean)){
    print(j)
    print(sub_penguines_clean[i, j])
    print("------COLS------>")
  }
}




# loop over whole penguins_loop dataset
for (i in 1:nrow(penguins_loop)){
  # print(paste0("-------->  ", i))
  
  mass <- penguins_loop$body_mass_g[i]
  # print(paste0("---->  ", mass))
  
  if (is.na(mass)){
    penguins_loop$weight_class[i] <- NA
  } else if (mass > 4100){
    penguins_loop$weight_class[i] <- "Heavy"
  } else if (mass < 3600){
    penguins_loop$weight_class[i] <- "Light"
  } else {
    penguins_loop$weight_class[i] <- "medium"
  }
  # print(penguins_loop$weight_class[i])
}

View(penguins_loop)
unique(penguins_loop$weight_class)


# define a func for the apply 

classify_weight <- function(row){
  mass <- row["body_mass_g"]
  if (is.na(mass)){
    return(NA)
  } else if (mass > 4100){
    return("Heavy")
  } else if (mass < 3600){
    return("Light")
  } else {
    return("Medium")
  }
}

penguins_apply <- penguins_clean
penguins_apply$weight_class <- apply(penguins_apply, 1, classify_weight)

head(penguins_loop)

# ifelse()
penguins$long_bill <- ifelse(penguins$bill_length_mm > 43, "YES", "NO")
  
penguins <- penguins[, 1:(ncol(penguins) - 1)]

head(penguins)

penguins$bill_length_class <- ifelse(
  penguins$bill_length_mm > 51, "Very long",
  ifelse(penguins$bill_length_mm > 43, "Long", "Short"))
  
unique(penguins$bill_length_class)


# beginner excerise
# has_long_bill
penguine$has_long_bill <- ifelse()
#intermediate bill category

# > range(penguins_clean$flipper_length_mm, na.rm = T)
# [1] 172 231
# advance
# > 200; < 180

penguins <- penguins %>% 
              mutate(flipper_cat = case_when(
                flipper_length_mm > 200 ~ "very long",
                flipper_length_mm > 190 ~ "long",
                TRUE ~ "short" 
              ))

source("./script/req.R")

# numerical col
numeric_cols <- select(penguins, where(is.numeric))

# cal means of all numerical col
map(numeric_cols, ~mean(.x, na.rm = T))

# get the stats of numerical cols
map_result <- map(numeric_cols, function(x) {
                  list(mean = mean(x, na.rm = T),
                       sd = sd(x, na.rm = T),
                       median = median(x, na.rm = T)
                    )
                  }
                )


penguins %>% 
  head(.)



# paralled processing
species_list <- split(penguins, penguins$species)
# unique(penguins$species)
length(species_list)


# start a cluster
cl <- makeCluster(3)
registerDoParallel(cl)

rbinded_res <- foreach(df = species_list, .combine = rbind) %dopar% {
                  data.frame(
                    species = unique(df$species),
                    avg_flipper = mean(df$flipper_length_mm, na.rm = T),
                    max_mass = max(df$body_mass_g, na.rm = T)
                  )
                }

stopCluster(cl)
print(rbinded_res)


# need to be check again ####
res_micro_bench <- microbenchmark(
                     apply = apply(numeric_cols, 1, mean, na.rm = T),
                     map = map_dbl(1:nrow(numeric_cols), ~ mean(as.numeric(numeric_cols[.x,]), na.rm = T)),
                    foreach = rbinded_res <- foreach(df = species_list, .combine = rbind) %dopar% {
                      data.frame(
                        species = unique(df$species),
                        avg_flipper = mean(df$flipper_length_mm, na.rm = T),
                        max_mass = max(df$body_mass_g, na.rm = T)
                      )
                    },
                      times = 10
                    )

row_means_for <- function(df) {
                    means <- numeric(nrow(df))
                    for (i in seq_len(nrow(df))) {
                      means[i] <- mean(as.numeric(df[i, ]), na.rm = TRUE)
                    }
                    return(means)
                  }


res_micro_bench <- microbenchmark(
  apply = apply(numeric_cols, 1, mean, na.rm = TRUE),
  map_dbl = map_dbl(1:nrow(numeric_cols), ~ mean(as.numeric(numeric_cols[.x,]), na.rm = TRUE)),
  internal_for = row_means_for(numeric_cols),
  times = 20
)
head(res_micro_bench)

# Convert to data frame and scale time to milliseconds
df <- as.data.frame(res_micro_bench)
df$time_ms <- df$time / 1e6  # Convert nanoseconds to milliseconds

# Boxplot grouped by method
boxplot(time_ms ~ expr,
        data = df,
        log = "y",  # log-scale helps if values differ greatly
        main = "Microbenchmark Execution Time",
        ylab = "Execution Time (milliseconds)",
        xlab = "Method",
        col = "lightblue")



ggplot(df, aes(x = expr, y = time_ms, fill = expr)) +
  geom_boxplot(alpha = 0.7) +
  scale_y_log10() +
  labs(title = "Microbenchmark Execution Time",
       x = "Method",
       y = "Execution Time (ms)") +
  theme_minimal() +
  theme(legend.position = "none")



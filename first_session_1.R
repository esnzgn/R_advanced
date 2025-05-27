

a = 31

# +
#   
# -
#   
#   *
#   
#   /
#   
#   ^
#   
  

5^4  
  

<
  
<=
  
>
  
>=
  
  
==
  
!=
  
# ligical operators

!  

&
  
|
  
  #  membership operator
%in%  
  
4 %in% 1:10 

4 == 1:10

10 = 20
10 == 20

10 - 20


1 + 7

13 - 10

4 * 6

12 / 3


#  some simple math 

5^4

16^(1/2)

3^2 - 5/2
(3^2 - 5)/2

#  T/F
2 + 2 == 4
2 + 2 == 5


a <- 1 + 2
a

a <- 10
a

b <- 5

c <- a + b

#  choosing names

age class 2 <- 32
age_class_2 <- 32


# objects
ab <- 1:10

# attibutes
length(ab)
class(ab)

dim(ab)


numeric_vector <- c(1, 2, 3)

character_vector <- c("apple", "cherry", "banana")

character_vector[2]

numeric_vector <= 2

# matrix 
matrix_variable <- matrix(NA, nrow = 2, ncol = 3)

# list
list_verstility <- list(numeric_vector, character_vector)

# some essential funcs
head()
tail()
nrow(matrix_variable)
dim(matrix_variable)

ncol(matrix_variable)

# functions
round()

# packages
library()

# error


# 
(5 + 3) * (6 - 2) / 2^2


# matrix 
set.seed(347)
large.matrix <- matrix(runif(25, 1, 100), nrow = 5)
dim(large.matrix)


row_sum <- rowSums(large.matrix)


col_means <- colMeans(large.matrix)

ages <- c(22, 32, 13, 35, 40, 50)
ages[ages > 30]

# ages[ages > 30 & ages < 45 & ages != 40] and not 40 

# define first fucntion 

calculate_area <- function(radius){
  area <- pi * radius^2
  return(area)
}

calculate_area(5)


employee_data <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David"),
  Age = c(25, 30, 35, 40),
  Salary = c(50000, 60000, 70000, 80000)
)

# mean salary of the employee df
mean(employee_data$Salary)

library(tibble)

employee_tibble <- tibble(
  Name = c("Alice", "Bob", "Charlie", "David"),
  Age = c(25, 30, 35, 40),
  Salary = c(50000, 60000, 70000, 80000)
)

employee_tibble

# subsetting
employee_data$Name[employee_data$Age > 30]

# loop
for (i in 1:5){
  print(i)
  print(i^2)
}

apply(employee_data[, (2,3)], 1, mean)



# is.numeric()

for (col_i in seq_along(employee_data)){
  print(col_i)  
  is_numeric[col_i] <- is.numeric(employee_data[, col_i])
  print(is_numeric)
}

apply(employee_data[,is_numeric], 1, mean)

# write a for loop instead of the apply function above
# rm(col_i)

outcome_row_mean <- NULL

for (row_i in  1:nrow(employee_data)){
  print(mean(as.numeric(employee_data[row_i, is_numeric])))
  outcome_row_mean[row_i] <- mean(as.numeric(employee_data[row_i, is_numeric]))
}

# 1- storing the outcome of the above workflow in variable
# 2- define func called mean_cal to find the mean of col or rows based on user preferences

mean_cal <- function(data, by = "row", is_numeric){
  # check if the user want the col or row
  if (by == "row"){
    result <- apply(employee_data[,is_numeric], 1, mean)
  } else if (by = "column") {
    result <- apply(employee_data[,is_numeric], 2, mean)
  }
  # return final result
  return(result)
}













# structure
project_folder/
│
├── data/
│   ├── data.csv
│   ├── processed_data.rds
│
├── scripts/
│   ├── data_preparation.R
│   ├── data_analysis.R
│   ├── visualization.R
│   ├── helper_functions.R
│
├── output/
│   ├── result.csv
│
├── README.md
│
├── project.Rproj




  
  
  
  
  
  
  
  
  
    
  

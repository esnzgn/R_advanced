
# R Programming: Day 1 - Introduction, Basics, and Piping

This is the first day of our R programming course, where we will lay a strong foundation by exploring basic R syntax, operators, and functions, followed by practical work with data. By the end of this day, you will be comfortable with basic operations in R, handling data structures, and using pipes (`%>%`) for more readable and efficient code.

---

## Table of Contents

- [Setting up RStudio](#1-setting-up-rstudio)
- [Basic Arithmetic Operations](#2-basic-arithmetic-operations)
- [Logical Operators](#3-logical-operators)
- [Membership Operator](#4-membership-operator)
- [Simple Math](#5-simple-math)
- [Choosing Names](#6-choosing-names)
- [Objects and Data Types](#7-objects-and-data-types)
- [Attributes](#8-attributes)
- [Matrices, Dataframes, and Vectors](#9-matrices-dataframes-and-vectors)
- [Functions](#10-functions)
- [Packages](#11-packages)
- [Repositories and Installation](#12-repositories-and-installation)
- [Subsetting](#13-subsetting)
- [For Loops](#14-for-loops)
- [Apply Functions](#15-apply-functions)
- [Best Practices for Project Structure](#16-best-practices-for-project-structure)
- [Creating and Sourcing Files](#17-creating-and-sourcing-files)
- [Penguin Analysis Project](#18-penguin-analysis-project)

---

## 1. Setting up RStudio

RStudio is the Integrated Development Environment (IDE) we will use for this course. It simplifies working with R by providing a user-friendly interface. The main panels you'll use are:

- **Console**: Where you can directly type and execute R commands.
- **Script Editor**: Where you write and save your R code.
- **Environment**: Shows all the variables and objects in your workspace.
- **Plots**: Displays visual outputs, like graphs.

---

## 2. Basic Arithmetic Operations

Start by performing simple arithmetic calculations in the R console.

### Example 1: Simple Arithmetic

```r
10 + 20
```

**Output:**
```r
[1] 30
```

---

## 3. Logical Operators

Logical operators help evaluate conditions:

- **`==`**: Exactly equal to
- **`!=`**: Not equal to
- **`<`**: Less than
- **`>`**: Greater than
- **`&`**: AND
- **`|`**: OR
- **`!`**: NOT

### Example 2: Using Logical Operators

```r
x <- 5
x > 3 & x < 10  # TRUE because both conditions are true
```

---

## 4. Membership Operator

The **membership operator** (`%in%`) is used to check if a value is present in a vector or list.

### Example 3: Membership Operator

```r
x <- c(1, 2, 3, 4, 5)
3 %in% x  # TRUE because 3 is in the vector
```

---

## 5. Simple Math

Perform more complex math operations, including exponentiation and square roots:

### Example 4: Exponentiation and Square Roots

```r
5^4  # Raise 5 to the power of 4
sqrt(16)  # Square root of 16
```

---

## 6. Choosing Names

Choosing clear, informative variable names is essential for readability.

### Example 5: Using Descriptive Names

```r
# Bad
x <- 100

# Good
flipper_length <- 100
```

---

## 7. Objects and Data Types

R has various data types, including **character**, **numeric**, **integer**, **logical**, and **complex**.

### Example 6: Creating Objects

```r
num <- 10        # Numeric
char <- "Hello"  # Character
flag <- TRUE     # Logical
```

---

## 8. Attributes

Attributes in R include properties like `names()`, `dim()`, and `length()` that help describe the structure of an object.

### Example 7: Using Attributes

```r
a <- c(1, 2, 3)
names(a) <- c("first", "second", "third")
print(a)
```

---

## 9. Matrices, Dataframes, and Vectors

In R, vectors are the most basic data structure, but we often work with **matrices** and **dataframes**.

### Example 8: Creating a Matrix

```r
m <- matrix(1:6, nrow = 2, ncol = 3)
print(m)
```

### Example 9: Creating a Dataframe

```r
df <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
print(df)
```

---

## 10. Functions

Functions allow you to define reusable blocks of code. Here's an example of a simple function:

### Example 10: Creating a Function

```r
square <- function(x) {
  return(x^2)
}
square(5)
```

---

## 11. Packages

R packages extend the functionality of R. To install a package, use `install.packages()`. To load a package, use `library()`.

### Example 11: Installing and Loading Packages

```r
install.packages("ggplot2")
library(ggplot2)
```

---

## 12. Repositories and Installation

R uses **CRAN** for package distribution, but you can also install packages from **GitHub**.

### Example 12: Installing from GitHub

```r
# Install devtools to install from GitHub
install.packages("devtools")
devtools::install_github("hadley/ggplot2")
```

---

## 13. Subsetting

You can extract specific elements from vectors, data frames, or matrices.

### Example 13: Subsetting a Dataframe

```r
df$Age  # Extracting the "Age" column
df[1, ] # Extracting the first row
```

---

## 14. For Loops

Loops help you repeat tasks multiple times.

### Example 14: Using a For Loop

```r
for (i in 1:5) {
  print(i^2)
}
```

---

## 15. Apply Functions

The **apply** family of functions (e.g., `apply()`, `lapply()`) allows you to apply a function to data structures like matrices or lists.

### Example 15: Using `apply()`

```r
m <- matrix(1:6, nrow = 2)
apply(m, 1, sum)  # Apply sum to each row
```

---

## 16. Best Practices for Project Structure

Organizing your project with a consistent folder structure is important for reproducibility.

### Example 16: Directory Structure

```plaintext
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
│
├── output/
│   ├── result.csv
│
├── README.md
│
├── project.Rproj
```

---

## 17. Creating and Sourcing Files

You can automatically create directories and files in R.

### Example 17: Create Files and Directories

```r
dir.create("scripts")
file.create("scripts/data_analysis.R")
```

---

## 18. Penguin Analysis Project

In this section, we use the **palmerpenguins** dataset to perform data analysis using R.

### Example 18: Penguin Data Analysis

```r
library(dplyr)
library(palmerpenguins)

# Clean the data
penguin_clean <- janitor::clean_names(penguins_raw)

# Calculate mean flipper length and culmen ratio
penguin_analysis <- penguin_clean %>%
  select(species, island, culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  drop_na(culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  mutate(culmen_ratio = culmen_length_mm / culmen_depth_mm) %>%
  group_by(species, island) %>%
  summarise(mean_flipper_length = mean(flipper_length_mm),
            mean_culmen_ratio = mean(culmen_ratio)) %>%
  arrange(species, island)

# View summary
print(penguin_analysis)
```

---

## Conclusion

By the end of today’s session, you should be comfortable with basic R syntax, logical operations, working with data structures like vectors and dataframes, and performing basic data analysis using the **palmerpenguins** dataset.

---

# Assignment

1. Experiment with additional arithmetic operations.
2. Try subsetting vectors and dataframes.
3. Create a new function to calculate the area of a circle.
4. Practice working with for-loops and apply functions.


---
title: "R Programming: Day 1 - Introduction, Basics, and Piping"
author: "Ehsan"
date: "`r Sys.Date()`"
output: html_document
---

# Welcome to Day 1 of the R Programming Course

This is the first day of our R programming course, where we will lay a strong foundation by exploring basic R syntax, operators, and functions, followed by practical work with data. By the end of this day, you will be comfortable with basic operations in R, handling data structures, and using pipes (`%>%`) for more readable and efficient code.

---

## Table of Contents

- [Setting up RStudio](#1-setting-up-rstudio)
- [Basic Arithmetic Operations](#2-basic-arithmetic-operations)
- [Operators in R](#3-operators-in-r)
- [Working with Vectors](#4-working-with-vectors)
- [Handling Errors in R](#5-handling-errors-in-r)
- [Writing and Organizing Scripts](#6-writing-and-organizing-scripts)
- [Piping in R](#7-piping-in-r)
- [Penguin Analysis Project](#8-penguin-analysis-project)

---

## 1. Setting up RStudio

RStudio is the Integrated Development Environment (IDE) we will use for this course. It makes working with R much easier by providing an interactive console, script editor, and other helpful tools. It is crucial to familiarize yourself with the RStudio interface, which includes the **Console**, **Script Editor**, **Environment**, and **Plots** panels.

We will be running all the code and examples in this course through RStudio.

---

## 2. Basic Arithmetic Operations

Let’s begin with some simple arithmetic operations to get comfortable with the R console. Open the **Console** and type the following:

```r
10 + 20
```

**Output:**
```r
[1] 30
```

This is a simple addition operation. In R, the `>` symbol is the prompt, and you don’t need to type it.

To print values explicitly, you can use `print()`:

```r
print(10 + 20)
```

---

## 3. Operators in R

R supports several operators for arithmetic and comparisons:

### Assignment Operator

Use `<-` for assigning values to variables:

```r
a <- 10 + 20
```

### Arithmetic Operators

- **`+`**: Addition
- **`-`**: Subtraction
- **`*`**: Multiplication
- **`/`**: Division
- **`^`**: Exponentiation

Example:

```r
5^4
```

**Output:**
```r
[1] 625
```

### Relational Operators

Used to compare values:

- **`==`**: Exactly equal to
- **`<`**: Less than
- **`>`**: Greater than

---

## 4. Working with Vectors

In R, a **vector** is a sequence of elements of the same type. Here’s how you create and access a vector:

### Create a Vector

```r
my_vector <- c(1, 2, 3, 4, 5)
```

### Access Elements in a Vector

```r
my_vector[3]  # Access the third element
```

**Output:**
```r
[1] 3
```

---

## 5. Handling Errors in R

R is sensitive to syntax errors, and even small mistakes can lead to errors. Here's an example of a common typo:

```r
10 = 20  # Error in syntax
```

**Error:**
```r
Error in 10 = 20 : invalid (do_set) left-hand side to assignment
```

Always check the error message and fix the syntax accordingly.

---

## 6. Writing and Organizing Scripts

RStudio allows you to write and organize your code into **scripts**. This helps you save and rerun your code later. You can create a script by clicking **File > New File > R Script**.

Here’s how to save a script and run it:

### Example: Create a Square Function

```r
# square_number.R
square_number <- function(x) {
  return(x^2)
}

# Call the function
square_number(5)
```

Run this script in the console using `source()`:

```r
source("square_number.R")
```

---

## 7. Piping in R

Piping with `%>%` is a powerful way to write cleaner and more readable code. The pipe operator allows you to pass the output of one function directly into the next function. It helps avoid nested functions and makes code more intuitive.

Here’s an example of using the pipe operator with **dplyr** functions:

### Example: Basic Data Manipulation with Pipes

```r
library(dplyr)

# Example Data
penguins_clean <- janitor::clean_names(penguins_raw)

penguins_clean %>%
  select(species, island, culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  drop_na(culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  mutate(culmen_ratio = culmen_length_mm / culmen_depth_mm) %>%
  group_by(species, island) %>%
  summarise(mean_flipper_length = mean(flipper_length_mm),
            mean_culmen_ratio = mean(culmen_ratio)) %>%
  arrange(species, island)
```

This approach is efficient and ensures each step is clearly stated and logically connected.

---

## 8. Penguin Analysis Project

### The penguin analysis project demonstrates how to clean, manipulate, and visualize data using pipes. The task is to calculate the mean flipper length and culmen ratio for each species of penguins, grouped by island.

### Example: Data Cleaning and Summarizing

```r
library(dplyr)
library(palmerpenguins)

# Clean data and perform analysis
penguins_clean <- janitor::clean_names(penguins_raw)

penguins_clean %>%
  select(species, island, culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  drop_na(culmen_length_mm, culmen_depth_mm, flipper_length_mm) %>%
  mutate(culmen_ratio = culmen_length_mm / culmen_depth_mm) %>%
  group_by(species, island) %>%
  summarise(mean_flipper_length = mean(flipper_length_mm),
            mean_culmen_ratio = mean(culmen_ratio)) %>%
  arrange(species, island) -> penguins_culmen_ratio

# View the summarized table
print(penguins_culmen_ratio)
```

### Example: Data Visualization

Here’s how to visualize the relationship between culmen length and depth:

```r
penguins_clean %>%
  ggplot(aes(x = culmen_length_mm, y = culmen_depth_mm, color = species)) +
  geom_point() +
  labs(x = "Culmen Length (mm)", y = "Culmen Depth (mm)") +
  theme_minimal()
```

This visualizes the relationship between the two variables, highlighting species using different colors.

---

## Conclusion

Today we covered key concepts in R, including basic syntax, arithmetic operations, working with vectors, error handling, and organizing code. We also introduced the piping operator (`%>%`) for cleaner, more readable code. The penguin analysis project demonstrated how to apply these techniques in practice.

Stay tuned for more advanced concepts in R in upcoming sessions!

---

# Assignment

1. Run additional arithmetic operations and experiment with vectors in the console.
2. Create a function that calculates the square of a number and run it through a script.
3. Try using pipes for data manipulation and create a simple visualization of a dataset.

---

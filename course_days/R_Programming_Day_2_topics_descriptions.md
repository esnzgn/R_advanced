# R Programming: Day 2 - Apply Functions, Conditional Statements, and Efficiency

## Table of Contents

-   [Session 2: Apply and Apply Functions](#session-2-apply-and-apply-functions)
-   [Exploring Functional Programming Concepts](#exploring-functional-programming-concepts)
-   [Conditional Statements (if, ifelse) in R](#conditional-statements-if-ifelse-in-r)
-   [Enhancing Code Efficiency and Effectiveness](#enhancing-code-efficiency-and-effectiveness)

# Session 2: Apply and Apply Functions {#session-2-apply-and-apply-functions}

## 1. apply() and Apply Family Functions in R

R provides a family of functions, such as **apply()**, **sapply()**, **lapply()**, **tapply()**, and others, that allow you to apply functions to data structures like vectors, lists, and data frames.

### Example 1: Basic apply() Function

``` r
# Create a sample matrix

# Apply the sum function to each row (MARGIN = 1)
```

**Solution:**

``` r
```

### Example 2: sapply() Function

``` r
# Example list of vectors

# Apply sum to each element of the list
```

**Solution:**

``` r
```

### Example 3: lapply() Function

``` r
# Apply the mean function to each column of the penguins data
```

**Solution:**

``` r
```

## Assignment - Apply Functions

1.  **Simple**: Create a 3x3 matrix of random numbers and use **apply()** to calculate the sum of each row.
2.  **Medium**: Use **sapply()** to calculate the product of each list element in a list of numeric vectors.
3.  **Hard**: Write a custom function that uses **lapply()** to compute the mean and standard deviation for each species in the penguins dataset, and returns the results in a list.

# Exploring Functional Programming Concepts {#exploring-functional-programming-concepts}

Functional programming in R involves writing functions and applying them to data structures like lists, vectors, and data frames. The core functional programming concept is **apply()** and related functions, but it also extends to **for-loops** and **map** functions.

### Example 1: Using a For-loop

``` r
# Simple for-loop to calculate ...
```

**Solution:**

``` r
```

### Example 2: map() Function from `purrr` package

``` r
library(purrr)

# List of numbers


# Use map() to apply the square function to each element
```

**Solution:**

``` r
```

## Assignment - Functional Programming

1.  **Simple**: Use a for-loop to calculate the sum of squares of the numbers from 1 to 10.
2.  **Medium**: Write a function using **map()** from `purrr` that calculates the sum of each list element in a list of numeric vectors.
3.  **Hard**: Combine a **for-loop** and **apply()** to calculate the cumulative sum of `flipper_length_mm` by species in the penguins dataset.

# Conditional Statements (if, ifelse) in R {#conditional-statements-if-ifelse-in-r}

### Example 1: Basic if-else Statement

``` r

if else
```

**Solution:**

``` r
```

### Example 2: ifelse() Function

``` r
```

**Solution:**

``` r
```

### Example 3: Nested ifelse() Statement

``` r
```

**Solution:**

``` r
```

## Assignment - Conditional Statements

1.  **Simple**: Write an `if` statement to check if the number `x` is positive or negative.
2.  **Medium**: Use **ifelse()** to create a new vector categorizing `flipper_length_mm` as "Short", "Medium", or "Long" based on predefined cutoffs.
3.  **Hard**: Write a nested **ifelse()** statement to categorize penguins by both age and species.

# Enhancing Code Efficiency and Effectiveness {#enhancing-code-efficiency-and-effectiveness}

Writing efficient code in R means focusing on speed and memory usage. One way to achieve this is through vectorization and efficient function usage. Functions like **apply()** and **purrr** can be more efficient than loops, and using **data.table** can also help with large datasets.

### Example 1: Using apply() for Efficiency

``` r
```

### Example 2: Efficient Naming Practices

``` r
# Efficient and clear naming conventions for functions



# Using the function
```

## Assignment - Efficiency

1.  **Simple**: Write a function to calculate the sum of a vector and make it more efficient by handling NA values.
2.  **Medium**: Use **apply()** to calculate the row-wise mean of a data frame and compare it to the performance of a for-loop.
3.  **Hard**: Use **purrr** to iterate over multiple datasets and apply a custom function to clean and transform them.

# R Programming: Day 1 - Introduction, Basics, and Piping

## Session 3: Mastering Tidyverse

## 1. Tips and Tricks for Working with Multiple Files and Improving Dataframes

The Tidyverse provides efficient functions like **read_csv()**, **bind_rows()**, and **mutate()** for managing and cleaning data. These functions allow you to handle multiple files and improve the efficiency of your data manipulation processes.

## 2. Writing Functions within the Tidyverse Framework

Tidyverse promotes clear and concise functions. Writing functions within the Tidyverse framework allows you to write code that is both efficient and easy to read. Here's an example of a custom function using Tidyverse functions:

``` r
```

------------------------------------------------------------------------

### 📘 **Day 2 Assignments:**

#### **Session 2: Apply and Apply Functions**

1.  **Easy:** Create a matrix of random numbers and use **apply()** to calculate the sum of each row.
2.  **Medium:** Write a function using **lapply()** to calculate the mean of numeric columns in a data frame.
3.  **Hard:** Use **sapply()** and **apply()** together to process the penguins dataset and return the mean and standard deviation of selected columns.

#### **Session 3: Mastering Tidyverse**

1.  **Easy:** Use **mutate()** to create a new column in the penguins dataset that calculates the ratio of `culmen_length_mm` to `culmen_depth_mm`.
2.  **Medium:** Write a function that uses **group_by()** and **summarise()** to calculate the mean `flipper_length_mm` by species.
3.  **Hard:** Use **purrr** to iterate over multiple datasets and apply a custom function to clean and transform them.

------------------------------------------------------------------------

#### **Required Steps to Do**

1.  **Sign up for the next session** at the following link: [Shiny Apps](https://www.shinyapps.io/)

2.  **Download all supplemental materials**, [Link to paper](https://www.cell.com/cell/fulltext/S0092-8674(19)31385-6?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS0092867419313856%3Fshowall%3Dtrue), specifically:

    -   Spreadsheet (27.58 KB) file
    -   Spreadsheet (57.66 MB) file
    -   Spreadsheet (7.90 MB) file

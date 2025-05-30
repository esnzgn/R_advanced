# =========================
# script Name: requirments.R
# purpose: required packages for analyze penguin dataset to cal mean flipper length and culmen ratios
# Author: Ehsan
# Data: 27.05.2025
# .rs.restartR()
# cat("\014")
# =========================
# BiocManager::install("palmerpenguins") #CRAN package

# loading packages
library(dplyr)
library(ggplot2)
library(palmerpenguins)
library(tidyr)
library(tibble)
library(purrr)
library(microbenchmark)
library(foreach)
library(doParallel)

library(tidyverse)

library(patchwork)

# BiocManager::install("compiler")
library(compiler)

library(profvis)

# data I/O
library(data.table)
library(readr)

# BiocManager::install("ggdensity")
library(ggdist)
library(ggdensity)

# BiocManager::install("ggridges")
library(ggridges)


#
# BiocManager::install("gt")
library(gt)





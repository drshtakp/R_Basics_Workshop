# =====================================================================
# COMPREHENSIVE GUIDE TO READING DIFFERENT FILE TYPES IN R
# Purpose: Learn how to import various file formats into R
# Topics: STATA, SPSS, SAS, Excel, CSV, and Data files
# =====================================================================

# Install required packages
# haven: For reading SPSS, STATA and SAS files
# readxl: For reading Excel files
# tidyr: For data manipulation
# install.packages(c("haven", "readxl", "tidyr"))
# Load required libraries
library(haven)      # For SPSS, STATA and SAS files
library(readxl)     # For excel files
library(tidyr)      # For data manipulation
library(dplyr)      # For data transformation
library(stringr)
# =====================================================================
# PART 1: READING STATA FILES
# Purpose: Import and handle STATA data files
# =====================================================================

# Method 1: Using read_stata()
# Reading STATA file from URL
# Source: Principles of Econometrics dataset
quizzes_data <- read_stata("http://www.principlesofeconometrics.com/stata/quizzes.dta")

# Preview the data
head(quizzes_data)  # Look at first few rows
str(quizzes_data)   # Examine structure

# Method 2: Using read_dta()
# Alternative method for reading STATA files
housing_df <- data.frame(
  read_dta("http://www.principlesofeconometrics.com/stata/housing.dta")
)

# Examine the housing dataset
head(housing_df)
summary(housing_df)

# =====================================================================
# PART 2: READING SPSS FILES
# Purpose: Import and handle SPSS data files
# =====================================================================

# Define SPSS file URL
# Example dataset: 2016 Health and Society student health survey data
spss_url <- "https://lo.unisa.edu.au/pluginfile.php/1020313/mod_book/chapter/106604/HLTH1025_2016.sav"

# Read SPSS file using read_spss()
# Convert directly to data frame for easier handling
health_survey_df <- data.frame(read_spss(spss_url))

# Examine the data
head(health_survey_df)
summary(health_survey_df)

# =====================================================================
# PART 3: READING SAS FILES
# Purpose: Import and handle SAS data files
# =====================================================================

# Define SAS file URL
sas_url <- "http://libguides.library.kent.edu/ld.php?content_id=11205331"

# Read SAS file
# Convert to data frame for consistent handling
sas_dataset <- data.frame(read_sas(sas_url))

# Examine the data
head(sas_dataset)
str(sas_dataset)

# Clean column names and handle missing values
sas_dataset_clean <- sas_dataset %>%
  # Remove spaces from column names
  rename_all(~gsub(" ", "_", .)) %>%
  # Convert empty strings to NA
  mutate(across(where(is.character), ~na_if(., "")))

# =====================================================================
# PART 4: READING EXCEL FILES
# Purpose: Import and handle Excel files
# =====================================================================

# Method 1: Reading local Excel file
# Note: Must set working directory first or use full path
# setwd("your/path/here")  # Set working directory if needed

# Read Excel file
# Note: Replace "SuperStoreUS_2015.xlsx" with your file name
excel_data <- read_excel("Datasets/SuperStoreUS-2015.xlsx")



# Examine the data
head(excel_data, n = 10)

# Reading specific sheet
excel_data_sheet2 <- read_excel("Datasets/SuperStoreUS-2015.xlsx", 
                                sheet = 2)  # Read second sheet


# =====================================================================
# PART 5: READING CSV FILES
# Purpose: Import and handle CSV files
# =====================================================================

# Reading CSV from URL
countries_data <- read.csv(
  "http://introcs.cs.princeton.edu/java/data/countries.csv",
  header = TRUE,    # First row contains column names
  sep = ","         # Comma separator
)

# Examine the data
head(countries_data)
str(countries_data)

# Additional CSV reading options
countries_data_advanced <- read.csv(
  "http://introcs.cs.princeton.edu/java/data/countries.csv",
  header = TRUE,           # First row as headers
  sep = ",",              # Comma separator
  stringsAsFactors = FALSE, # Keep strings as character
  na.strings = c("", "NA", "NULL"),  # Define NA values
  encoding = "UTF-8"      # Specify encoding
)

write.csv(countries_data_advanced, "data.csv", row.names = FALSE)
# =====================================================================
# PART 6: READING .DATA FILES
# Purpose: Import and handle .data files (common in UCI ML Repository)
# =====================================================================

# Define URL for .data file
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/balloons/adult-stretch.data"

# Read .data file
balloons_data <- read.table(
  url,
  sep = "\t",     # Tab separator
  dec = ","       # Decimal point character
)

# Examine raw data
head(balloons_data)

# Define column names for separation
col_names <- c("Color", "size", "act", "age", "inflated")

# Separate single column into multiple columns
sep_data <- separate(
  balloons_data,
  col = "V1",           # Column to separate
  into = col_names,     # New column names
  sep = ","             # Separator in the data
)

# Examine cleaned data
head(sep_data)
str(sep_data)

# Additional data cleaning steps
clean_balloons_data <- sep_data %>%
  # Convert to factors where appropriate
  mutate(across(everything(), as.factor)) %>%
  # Remove any leading/trailing whitespace
  mutate(across(everything(), str_trim))



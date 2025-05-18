# ===============================================
# DATA MANIPULATION TUTORIAL
# This covers essential data manipulation techniques
# using two datasets: gapminder and babynames
# ===============================================

# First, install required packages if you haven't already
# tidyverse includes dplyr and other data manipulation tools
# gapminder contains country-level economic and social indicators
if (!require(gapminder)) install.packages("gapminder")
if (!require(babynames)) install.packages("babynames")
# Load the required libraries
# Note: Always load libraries at the start of your script
library(gapminder)  # Contains country economic and social data
library(dplyr)      # Main data manipulation package
library(tidyverse)  # Collection of data science packages

# ===================================
# PART 1: GAPMINDER DATASET BASICS
# ===================================

# Look at the basic structure of gapminder dataset
# This dataset contains 1704 rows and 6 columns
# Variables: country, continent, year, lifeExp, pop, gdpPercap
gapminder  
str(gapminder)
typeof(gapminder)
# ===================================
# BASIC DATA MANIPULATION VERBS
# ===================================

# 1. FILTER - Subsetting Data
# filter() is used when you want to extract specific rows based on conditions

# Get data for only the year 2007
# The == operator checks for exact equality
gapminder %>%  # %>% is the pipe operator: takes left side and feeds to right side
  filter(year == 2007)  # Only keep rows where year equals 2007

# Get data for Belgium only
gapminder %>%
  filter(country == "Belgium")  # Only keep rows where country is Belgium

# Multiple conditions using AND logic (comma represents AND)
gapminder %>%
  filter(country == "Belgium", year == 2007)  # Must satisfy both conditions

# 2. ARRANGE - Sorting Data
# arrange() orders the rows based on values in specified columns

# Sort by GDP per capita (ascending order by default)
gapminder %>%
  arrange(gdpPercap)  # Lowest to highest GDP per capita

# Sort by GDP per capita in descending order using desc()
gapminder %>%
  arrange(desc(gdpPercap))  # Highest to lowest GDP per capita

# Combining filter and arrange
# Example: Find highest population countries in 1957
gapminder %>%
  filter(year == 1957) %>%         # First filter for 1957
  arrange(desc(pop))               # Then sort by population (descending)

# 3. MUTATE - Creating or Modifying Variables
# mutate() adds new variables or modifies existing ones

# Convert population to millions for easier interpretation
gapminder %>%
  mutate(pop = pop/1000000)  # Divide population by 1 million

# Create total GDP by multiplying population and GDP per capita
gapminder %>%
  mutate(total_gdp = gdpPercap * pop)  # New column with total GDP

# Multiple operations with mutate
gapminder %>%
  mutate(
    pop_millions = pop/1000000,              # Create population in millions
    total_gdp = gdpPercap * pop,             # Calculate total GDP
    gdp_billions = total_gdp/1000000000      # Convert GDP to billions
  )

# 4. SUMMARIZE - Computing Summary Statistics
# summarize() (or summarise()) collapses many rows into a single row

# Calculate mean life expectancy across all observations
gapminder %>%
  summarise(mean_life_exp = mean(lifeExp))  # Average of all life expectancy values

# Multiple summary statistics
gapminder %>%
  filter(year == 2007) %>%  # Focus on 2007 only
  summarise(
    mean_life_exp = mean(lifeExp),    # Average life expectancy
    total_pop = sum(as.numeric(pop)),  # Total population
    countries = n(),                   # Number of countries
    median_gdp = median(gdpPercap)     # Median GDP per capita
  )

# 5. GROUP BY - Grouping Data for Analysis
# group_by() groups the data by specified variables before operations

# Calculate statistics by continent
gapminder %>%
  group_by(continent) %>%  # Group data by continent
  summarise(
    avg_life_exp = mean(lifeExp),      # Average life expectancy per continent
    total_pop = sum(as.numeric(pop)),   # Total population per continent
    n_countries = n_distinct(country)   # Number of countries per continent
  )

# Multiple grouping variables
gapminder %>%
  group_by(continent, year) %>%  # Group by both continent and year
  summarise(
    avg_gdp = mean(gdpPercap),   # Average GDP per capita for each group
    total_pop = sum(as.numeric(pop))  # Total population for each group
  )

# To view all rows, can use %>% print(n=) or %>% view() or %>% data.frame

# ===================================
# ADVANCED DATA MANIPULATION
# ===================================

# 1. COUNT - Counting Observations
# count() is a shortcut for group_by() + summarise(n())

# Count number of observations per continent
gapminder %>%
  count(continent, sort = TRUE)  # sort=TRUE orders from highest to lowest

# Weighted counts (e.g., total population by continent)
gapminder %>%
  count(continent, wt = pop, sort = TRUE)  # Using population as weights

# 2. TOP_N - Finding Extreme Values
# top_n() selects the n highest (or lowest) values

# Find the 3 most populous countries in each continent
gapminder %>%
  group_by(continent) %>%
  top_n(3, pop) %>%  # Select top 3 based on population
  arrange(continent, desc(pop))  # Arrange for better viewing

# 3. SELECT AND RENAME - Column Operations
# select() chooses columns, rename() changes column names

# Select specific columns
gapminder %>%
  select(country, continent, pop) %>%  # Keep only these three columns
  rename(population = pop)             # Rename pop to population

# Select columns using helper functions
gapminder %>%
  select(country, starts_with("pop")) %>%  # Select columns starting with "pop"
  head()                                   # Show first few rows

# ===============================================
# PART 2: BABYNAMES DATASET ANALYSIS
# ===============================================

library(babynames)  # Load babynames dataset

# Examine the structure of babynames dataset
# Contains: year, sex, name, n (number of babies), prop (proportion)
str(babynames)

# ===================================
# BASIC NAME ANALYSIS
# ===================================

# 1. Most Popular Names of All Time
popular_names <- babynames %>%
  group_by(name, sex) %>%            # Group by name and sex
  summarise(
    total_babies = sum(n),           # Total babies with this name
    years_present = n(),             # Number of years this name appeared
    first_year = min(year),          # First appearance
    last_year = max(year),           # Most recent appearance
    max_count = max(n)               # Maximum usage in any year
  ) %>%
  arrange(desc(total_babies)) %>%    # Sort by total usage
  head(10)                          # Show top 10

# 2. Names by Decade
decade_analysis <- babynames %>%
  mutate(decade = floor(year/10) * 10) %>%  # Create decade variable
  group_by(decade, sex) %>%                 # Group by decade and sex
  summarise(
    unique_names = n_distinct(name),        # Count unique names
    total_babies = sum(n),                  # Total babies named
    avg_babies_per_name = mean(n)           # Average usage per name
  )

# ===================================
# ADVANCED NAME ANALYSIS
# ===================================

# 1. Trendy Names
# Find names that became very popular very quickly
trendy_names <- babynames %>%
  group_by(name, sex) %>%
  filter(n >= 100) %>%                # Focus on names with some popularity
  arrange(year) %>%                   # Order by year
  mutate(
    growth = n / lag(n),             # Calculate year-over-year growth
    max_growth = max(growth, na.rm = TRUE)  # Find maximum growth rate
  ) %>%
  ungroup() %>%
  filter(max_growth >= 10) %>%        # Names that grew 10x or more in one year
  arrange(desc(max_growth)) %>%
  view()

# 2. Gender-Neutral Names
# Find names used significantly for both sexes
neutral_names <- babynames %>%
  filter(year >= 1950) %>%           # Focus on more recent years
  group_by(year, name) %>%
  filter(n() == 2) %>%               # Must appear for both sexes
  summarise(
    total = sum(n),                  # Total babies
    ratio = max(n) / min(n),         # Ratio between sexes
    .groups = 'drop'
  ) %>%
  filter(
    total >= 100,                    # Must have some minimum popularity
    ratio <= 2                       # Relatively balanced between sexes
  ) %>%
  arrange(ratio)

# ===================================
# PRACTICE EXERCISES
# ===================================

# Exercise 1: Name Length Analysis
name_length_trends <- babynames %>%
  # Calculate name length
  mutate(name_length = nchar(name)) %>%
  # Group by year and sex
  group_by(year, sex) %>%
  # Calculate average length
  summarise(
    avg_length = mean(name_length),
    median_length = median(name_length),
    max_length = max(name_length),
    min_length = min(name_length)
  )

# Exercise 2: Generation Gap Analysis
# Find names popular in grandparents' era (1950s) and now, but not in between
generation_gap <- babynames %>%
  filter(year >= 1950) %>%
  mutate(
    generation = case_when(
      year < 1960 ~ "1950s",
      year >= 2010 ~ "2010s",
      TRUE ~ "between"
    )
  ) %>%
  group_by(name, sex, generation) %>%
  summarise(
    avg_count = mean(n),
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = generation,
    values_from = avg_count
  ) %>%
  filter(
    `1950s` >= 100,    # Popular in 1950s
    `2010s` >= 100,    # Popular now
    between <= 50      # Less popular in between
  )

# Exercise 3: Regional Variation
# Note: This would require state-level data, which isn't in this dataset
# This is just an example structure
state_variation <- babynames %>%
  group_by(name, sex, year) %>%
  summarise(
    total_count = sum(n),
    .groups = 'drop'
  )

# Exercise 4: Name Endings Analysis
name_endings <- babynames %>%
  # Extract last letter of each name
  mutate(
    last_letter = substr(name, nchar(name), nchar(name))
  ) %>%
  group_by(year, sex, last_letter) %>%
  summarise(
    name_count = n(),
    total_babies = sum(n),
    .groups = 'drop'
  ) %>%
  arrange(year, sex, desc(name_count))

# ===================================
# PRACTICE QUESTIONS AND SOLUTIONS
# ===================================

# Question 1: Which names have been consistently popular (top 100) for the longest time?
consistent_names <- babynames %>%
  group_by(year, sex) %>%
  mutate(rank = min_rank(desc(n))) %>%  # Calculate rank within each year
  filter(rank <= 100) %>%                # Keep only top 100 names
  group_by(name, sex) %>%
  summarise(
    years_in_top_100 = n(),
    first_year = min(year),
    last_year = max(year)
  ) %>%
  arrange(desc(years_in_top_100))

# Question 2: What are the most dramatically declining names?
declining_names <- babynames %>%
  group_by(name, sex) %>%
  filter(n() >= 50) %>%  # Names present for at least 50 years
  summarise(
    peak_count = max(n),
    peak_year = year[which.max(n)],
    current_count = n[year == max(year)],
    decline_ratio = peak_count / current_count
  ) %>%
  filter(peak_count >= 1000) %>%  # Focus on names that were once popular
  arrange(desc(decline_ratio))

# Question 3: Which names show the most regular cyclical patterns?
# This would require time series analysis, here's a simple version
cyclical_names <- babynames %>%
  group_by(name, sex) %>%
  filter(n() >= 50) %>%  # Names present for at least 50 years
  summarise(
    mean_count = mean(n),
    sd_count = sd(n),
    cv = sd_count / mean_count,  # Coefficient of variation
    peaks = sum(n > lag(n) & n > lead(n), na.rm = TRUE)  # Count of peaks
  ) %>%
  filter(mean_count >= 100) %>%  # Focus on reasonably popular names
  arrange(desc(peaks))

# Question 4: What are the most popular first letters for names by decade?
first_letters <- babynames %>%
  mutate(
    decade = floor(year/10) * 10,
    first_letter = substr(name, 1, 1)
  ) %>%
  group_by(decade, sex, first_letter) %>%
  summarise(
    total_babies = sum(n),
    unique_names = n_distinct(name)
  ) %>%
  arrange(decade, sex, desc(total_babies))
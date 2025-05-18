# R Basics Workshop

# ===================================
# 1. Introduction to R
# ===================================
# R is a powerful statistical programming language
# Let's start with some basic operations

# Using R as a calculator
2 + 2       # Addition
10 - 5      # Subtraction
4 * 3       # Multiplication
15 / 3      # Division
2 ^ 3       # Exponentiation
10 %% 3     # Modulus (remainder)

# ===================================
# 2. Variables and Assignment
# ===================================

# Using <- (preferred) for assignment
my_number <- 42
my_text <- "Hello, R!"

# Using = (also works, but <- is preferred in R)
age = 25

# Best practices for variable naming:
# Use descriptive names
average_height <- 170
# Use snake_case (lowercase with underscores)
first_name <- "John"
# Avoid starting with numbers
# 1st_value <- 10  # This would cause an error

# ===================================
# 3. Data Types
# ===================================

# Numeric (includes both integer and double)
x <- 10            # integer
y <- 10.5         # double

# Check data type
class(x)
class(y)

# Character
name <- "Alice"
class(name)

# Logical
is_student <- TRUE
has_car <- FALSE
class(is_student)

# Factors (categorical variables)
# Important for statistical analysis
gender <- factor(c("Male", "Female", "Male", "Female"))
levels(gender)     # View factor levels

# ===================================
# 4. Basic Math Operations and Functions
# ===================================

# Create a vector of numbers
numbers <- c(15, 8, 23, 42, 16, 10)

# Basic statistical functions
sum(numbers)       # Sum of all numbers
mean(numbers)      # Average
median(numbers)    # Median
max(numbers)       # Maximum value
min(numbers)       # Minimum value
sd(numbers)        # Standard deviation

# Generating sequences
seq(1, 10)                # Sequence from 1 to 10
seq(1, 10, by = 2)       # Sequence with step size 2
1:10                     # Another way to create sequence

# Random numbers
# Set seed for reproducibility
set.seed(123)
random_nums <- rnorm(5)   # 5 random numbers from normal distribution
runif(5)                  # 5 random numbers from uniform distribution

# ===================================
# EXERCISES
# ===================================

# Exercise 1: Basic Operations
# Create two variables 'a' and 'b' with values 15 and 3 respectively.
# Calculate their sum, difference, product, and quotient.

# Solution:
a <- 15
b <- 3

sum_result <- a + b      # Should be 18
diff_result <- a - b     # Should be 12
prod_result <- a * b     # Should be 45
quot_result <- a / b     # Should be 5

# Exercise 2: Data Types
# Create variables of different types and use class() to verify their types:
# - A number with decimal points
# - A whole number
# - A character string
# - A logical value

# Solution:
decimal_num <- 3.14
whole_num <- 42
text_string <- "R Programming"
logical_val <- TRUE

# Check classes
class(decimal_num)    # "numeric"
class(whole_num)      # "numeric"
class(text_string)    # "character"
class(logical_val)    # "logical"

# Exercise 3: Vector Operations
# Create a vector of temperatures (in Celsius) for a week
# Calculate the average, maximum, and minimum temperatures

# Solution:
temperatures <- c(23, 25, 22, 24, 21, 26, 23)
avg_temp <- mean(temperatures)
max_temp <- max(temperatures)
min_temp <- min(temperatures)

# Exercise 4: Factors
# Create a factor vector for education levels 
# (High School, Bachelor's, Master's, PhD)
# Count how many times each level appears

# Solution:
education <- factor(c("Bachelor's", "Master's", "PhD", 
                      "High School", "Bachelor's", "Master's"))
table(education)  # Shows frequency of each level

# Exercise 5: Random Numbers and Sequences
# Generate 10 random numbers between 1 and 100
# Create a sequence from 0 to 50 with steps of 5

# Solution:
set.seed(456)  # For reproducibility
random_100 <- sample(1:100, 10)
seq_by_5 <- seq(0, 50, by = 5)

# ===================================
# Additional Practice Questions:
# ===================================

# 1. Create a vector of 5 different fruits and convert it to a factor.
#    Then add another fruit and observe what happens.

# 2. Calculate the square root and square of numbers 1 to 5.

# 3. Generate 20 random numbers from a normal distribution 
#    with mean 100 and standard deviation 15.

# 4. Create two vectors of equal length and perform element-wise
#    multiplication and division.

# 5. Create a logical vector checking which numbers in a sequence
#    are greater than their mean.



















# Solutions to Additional Practice:

# 1. Fruits Example
fruits <- c("apple", "banana", "orange", "grape", "kiwi")
fruits_factor <- factor(fruits)
# Adding new fruit
new_fruits <- c(as.character(fruits_factor), "mango")
new_fruits_factor <- factor(new_fruits)

# 2. Square roots and squares
nums <- 1:5
sqrt_nums <- sqrt(nums)
squared_nums <- nums^2

# 3. Normal distribution
set.seed(789)
norm_nums <- rnorm(20, mean = 100, sd = 15)

# 4. Vector operations
vec1 <- c(1, 2, 3, 4, 5)
vec2 <- c(2, 4, 6, 8, 10)
element_mult <- vec1 * vec2
element_div <- vec1 / vec2

# 5. Logical vector
numbers <- 1:10
numbers_mean <- mean(numbers)
greater_than_mean <- numbers > numbers_mean
# R Data Structures

# ===================================
# 1. VECTORS
# ===================================

# Creating numeric vectors
numbers <- c(2, 5, 4, 1, 3)
decimals <- c(1.5, 2.5, 3.5)

# Creating character vectors
fruits <- c("apple", "banana", "orange")
names <- c("John", "Alice", "Bob")

# Creating logical vectors
is_passed <- c(TRUE, FALSE, TRUE, TRUE)

# Vector operations
nums1 <- c(1, 2, 3)
nums2 <- c(4, 5, 6)
nums1 + nums2        # Element-wise addition
nums1 * 2           # Multiply each element by 2
nums1 * nums2       # Element-wise multiplication

# Vector indexing (starts from 1 in R)
numbers[1]          # First element
numbers[c(1,3)]     # First and third elements
numbers[-2]         # All except second element
numbers[2:4]        # Elements from index 2 to 4

# Vector functions
length(numbers)     # Length of vector
sum(numbers)        # Sum of elements
mean(numbers)       # Average
sort(numbers)       # Sort in ascending order (default)
rev(numbers)        # Reverse the vector
# Does not change the vector inplace

# ===================================
# 2. LISTS
# ===================================

# Creating a basic list
student <- list(
  name = "John",
  age = 20,
  grades = c(85, 92, 78),
  passed = TRUE
)

# Accessing list elements
student$name              # Using $ operator
student[[1]]             # Using double brackets
student[["name"]]        # Using name in double brackets
student["name"]          # Returns a list

# Nested lists
class_info <- list(
  teacher = list(
    name = "Dr. Smith",
    subject = "Statistics"
  ),
  students = list(
    student1 = list(name = "John", grade = 85),
    student2 = list(name = "Alice", grade = 92)
  )
)

# Accessing nested elements
class_info$teacher$name
class_info$students$student1$grade

# ===================================
# 3. MATRICES
# ===================================

# Creating matrices
# By column (default)
matrix1 <- matrix(1:6, nrow = 2, ncol = 3)
# By row
matrix2 <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)

# Creating matrices from vectors
rows <- rbind(c(1,2,3), c(4,5,6))
cols <- cbind(c(1,2), c(3,4), c(5,6))

# Matrix operations
matrix1 + matrix2    # Element-wise addition
matrix1 * matrix2    # Element-wise multiplication
matrix1 %*% t(matrix2) # Matrix multiplication

# Accessing matrix elements
matrix1[1,2]        # Element at row 1, column 2
matrix1[1,]         # First row
matrix1[,2]         # Second column
matrix1[1:2, 2:3]   # Submatrix

# Matrix functions
dim(matrix1)        # Dimensions
nrow(matrix1)       # Number of rows
ncol(matrix1)       # Number of columns
t(matrix1)          # Transpose

# ===================================
# 4. DATA FRAMES
# ===================================

# Creating a data frame
students_df <- data.frame(
  name = c("John", "Alice", "Bob"),
  age = c(20, 22, 21),
  grade = c(85, 92, 78),
  passed = c(TRUE, TRUE, FALSE)
)

# Accessing data frame elements
students_df$name            # Single column
students_df[1,]            # First row
students_df[,2]            # Second column or students_df[[2]]
students_df[1:2, 2:3]      # Subset of rows and columns

# Adding new columns
students_df$height <- c(175, 162, 180)

# Removing columns
students_df$age <- NULL

# Filtering data frames
subset(students_df, grade > 80)
students_df[students_df$passed == TRUE,]

# Data frame functions
head(students_df)          # First few rows
summary(students_df)       # Summary statistics
str(students_df)          # Structure of data frame

# ===================================
# 5. ARRAYS
# ===================================

# Creating a 3D array (2x3x2)
arr <- array(1:12, dim = c(2,3,2))

# Accessing array elements
arr[1,2,1]               # Element at position [1,2,1]
arr[,,1]                 # First matrix
arr[,2,]                 # Second row of each matrix

# Array operations
dim(arr)                 # Dimensions
length(arr)              # Total number of elements
arr + 1                  # Add 1 to all elements

# ===================================
# EXERCISES
# ===================================

# Exercise 1: Vectors
# Create a vector of temperatures for 7 days
# Calculate:
# - Average temperature
# - Highest and lowest temperatures
# - How many days were above 25°C

# Solution:
temps <- c(23, 25, 28, 24, 22, 27, 26)
avg_temp <- mean(temps)
max_temp <- max(temps)
min_temp <- min(temps)
days_above_25 <- sum(temps > 25)

# Exercise 2: Lists
# Create a list containing information about a movie:
# - Title
# - Year
# - Main actors (vector)
# - Ratings (vector of numbers)
# Calculate the average rating

# Solution:
movie <- list(
  title = "The Matrix",
  year = 1999,
  actors = c("Keanu Reeves", "Laurence Fishburne", "Carrie-Anne Moss"),
  ratings = c(8.5, 9.0, 8.7, 8.9)
)
avg_rating <- mean(movie$ratings)

# Exercise 3: Matrices
# Create a 3x3 multiplication table
# Then:
# - Extract the diagonal elements
# - Calculate the sum of each row
# - Calculate the sum of each column

# Solution:
mult_table <- matrix(1:9, nrow = 3, ncol = 3) * matrix(1:9, nrow = 3, ncol = 3)
diag_elements <- diag(mult_table)
row_sums <- rowSums(mult_table)
col_sums <- colSums(mult_table)

# Exercise 4: Data Frames
# Create a data frame of 5 students with:
# - Name
# - Age
# - Three test scores
# Then:
# - Calculate average score for each student
# - Find students with average score above 80
# - Add a "Pass/Fail" column based on average score (>= 60 is Pass)

# Solution:
students <- data.frame(
  name = c("John", "Alice", "Bob", "Carol", "David"),
  age = c(20, 22, 21, 23, 20),
  test1 = c(85, 92, 78, 95, 88),
  test2 = c(88, 85, 82, 91, 85),
  test3 = c(90, 88, 75, 93, 82)
)

students$avg_score <- rowMeans(students[,c("test1", "test2", "test3")])
high_achievers <- subset(students, avg_score > 80)
students$status <- ifelse(students$avg_score >= 60, "Pass", "Fail")

# Exercise 5: Arrays
# Create a 2x2x3 array representing sales data for:
# - 2 products
# - 2 regions
# - 3 months
# Calculate:
# - Total sales per product
# - Total sales per region
# - Total sales per month

# Solution:
sales_data <- array(
  c(100,150,120,180,90,170,200,160,110,140,130,190),
  dim = c(2,2,3),
  dimnames = list(
    c("Product1", "Product2"),
    c("North", "South"),
    c("Jan", "Feb", "Mar")
  )
)

product_sales <- apply(sales_data, 1, sum)
region_sales <- apply(sales_data, 2, sum)
monthly_sales <- apply(sales_data, 3, sum)

# ===================================
# Additional Practice Questions:
# ===================================

# 1. Create a vector of numbers 1 to 20, then extract:
#    - All even numbers
#    - All numbers divisible by 3
#    - All numbers greater than 10 but less than 15

# 2. Create a nested list representing a family tree with
#    three generations. Include names and ages.

# 3. Create a 4x4 matrix where each element is the sum of
#    its row and column numbers.

# 4. Create a data frame of car data (model, year, price, mileage)
#    and perform various filtering operations.

# 5. Create a 3D array representing temperature data for:
#    - 4 cities
#    - 7 days
#    - 2 weeks
#    Calculate average temperature per city.



















# Solutions to Additional Practice:

# 1. Vector of numbers 1 to 20
(arr <- 1:20)
(even_arr <- arr[arr%%2==0])
(odd_arr <- arr[arr%%2==1])
(arr_between <- arr[arr>10 & arr<15])

# 3. Create a 4x4 matrix
(row_indices <- matrix(rep(1:4, each = 4), nrow = 4, ncol = 4))
# OR (col_indices <- matrix(rep(1:4, times = 4), nrow = 4, ncol = 4, byrow = TRUE))
(col_indices <- matrix(rep(1:4, times = 4), nrow = 4, ncol = 4))
(matrix_4x4 <- row_indices + col_indices)

# 5. Create a 3D array
set.seed(123)
(temperature_data <- array(runif(4 * 7 * 2, min = 20, max = 35), dim = c(4, 7, 2)))
(average_temperature_per_city <- apply(temperature_data, 1, mean))

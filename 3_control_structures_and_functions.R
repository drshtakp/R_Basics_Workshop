# R Control Structures and Functions 

# ===================================
# 1. IF-ELSE STATEMENTS
# ===================================

# Simple if statement
x <- 10
if (x > 5) {
  print("x is greater than 5")
}

# if-else construct
score <- 85
if (score >= 60) {
  print("Passed")
} else {
  print("Failed")
}

# if-else if-else construct
grade <- 75
if (grade >= 90) {
  print("A")
} else if (grade >= 80) {
  print("B")
} else if (grade >= 70) {
  print("C")
} else {
  print("D")
}

# Nested if statements
temp <- 25
is_sunny <- TRUE

if (temp > 20) {
  if (is_sunny) {
    print("Great day for a picnic!")
  } else {
    print("Warm but cloudy")
  }
} else {
  print("Too cold outside")
}

# ===================================
# 2. FOR LOOPS
# ===================================

# Basic for loop
for (i in 1:5) {
  print(paste("Number:", i))
}

# Looping over a vector
fruits <- c("apple", "banana", "orange")
for (fruit in fruits) {
  print(paste("I like", fruit))
}

# Loop with index
for (i in seq_along(fruits)) {
  print(paste("Fruit", i, "is", fruits[i]))
}

# Nested for loops
# Creating a multiplication table
for (i in 1:3) {
  for (j in 1:3) {
    print(paste(i, "x", j, "=", i*j))
  }
}

# Loop over a list
student_list <- list(
  student1 = list(name = "John", grade = 85),
  student2 = list(name = "Alice", grade = 92)
)

for (student in student_list) {
  print(paste(student$name, "scored", student$grade))
}

# ===================================
# 3. WHILE LOOPS
# ===================================

# Basic while loop
counter <- 1
while (counter <= 5) {
  print(counter)
  counter <- counter + 1
}

# While loop with break
number <- 1
while (TRUE) {
  if (number > 5) {
    break
  }
  print(number)
  number <- number + 1
}

# While loop with next (continue)
i <- 0
while (i < 5) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}

# ===================================
# 4. FUNCTIONS
# ===================================

# Basic function
calculate_square <- function(x) {
  return(x^2)
}

# Function with multiple parameters
calculate_rectangle_area <- function(length, width) {
  area <- length * width
  return(area)
}

# Function with default arguments
greet <- function(name = "User", greeting = "Hello") {
  return(paste(greeting, name))
}

# Function returning multiple values
calculate_statistics <- function(numbers) {
  return(list(
    mean = mean(numbers),
    sum = sum(numbers),
    max = max(numbers)
  ))
}

# Function with variable number of arguments
sum_all <- function(...) {
  args <- list(...)
  return(sum(unlist(args)))
}

# Function demonstrating scope
outer_function <- function() {
  x <- 10  # Local to outer_function
  
  inner_function <- function() {
    y <- 5  # Local to inner_function
    return(x + y)  # Can access x from outer scope
  }
  
  return(inner_function())
}

# ===================================
# 5. ANONYMOUS FUNCTIONS
# ===================================

# Basic anonymous function
numbers <- 1:5
squared <- sapply(numbers, function(x) x^2)

# Using anonymous function with apply
matrix_data <- matrix(1:9, nrow = 3)
row_sums <- apply(matrix_data, 1, function(x) sum(x))

# Anonymous function in lapply
list_data <- list(a = 1:3, b = 4:6)
list_means <- lapply(list_data, function(x) mean(x))

# ===================================
# EXERCISES
# ===================================

# Exercise 1: Control Flow
# Write a function that takes a numeric grade and returns:
# "A" for 90-100
# "B" for 80-89
# "C" for 70-79
# "D" for 60-69
# "F" for below 60

# Solution:
get_letter_grade <- function(score) {
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 70) {
    return("C")
  } else if (score >= 60) {
    return("D")
  } else {
    return("F")
  }
}

# Test the function
test_scores <- c(95, 88, 72, 65, 45)
sapply(test_scores, get_letter_grade)

# Exercise 2: Loops
# Write a function that prints the first n Fibonacci numbers
# using a while loop

# Solution:
print_fibonacci <- function(n) {
  a <- 0
  b <- 1
  count <- 1
  
  while (count <= n) {
    print(a)
    next_num <- a + b
    a <- b
    b <- next_num
    count <- count + 1
  }
}

# Test the function
print_fibonacci(8)

# Exercise 3: Nested Loops
# Create a function that prints a pattern of stars
# where the number of stars increases by row

# Solution:
print_star_pattern <- function(rows) {
  for (i in 1:rows) {
    for (j in 1:i) {
      cat("*")
    }
    cat("\n")
  }
}

# Test the function
print_star_pattern(5)

# Exercise 4: Function with Multiple Returns
# Create a function that analyzes a vector of numbers and returns
# a list containing the mean, median, max, min, and standard deviation

# Solution:
analyze_numbers <- function(numbers) {
  if (length(numbers) == 0) {
    return(NULL)
  }
  
  return(list(
    mean = mean(numbers),
    median = median(numbers),
    maximum = max(numbers),
    minimum = min(numbers),
    std_dev = sd(numbers)
  ))
}

# Test the function
test_numbers <- c(10, 20, 30, 40, 50)
analyze_numbers(test_numbers)

# Exercise 5: Anonymous Functions
# Use lapply with an anonymous function to calculate
# the range (max - min) for each vector in a list

# Solution:
number_lists <- list(
  a = c(1, 5, 3, 8, 2),
  b = c(10, 20, 15, 25),
  c = c(100, 101, 102, 99)
)

ranges <- lapply(number_lists, function(x) max(x) - min(x))

# ===================================
# Additional Practice Questions:
# ===================================

# 1. Write a function that checks if a number is prime

# 2. Create a function that reverses a string without
#    using built-in reverse functions

# 3. Write a function that calculates the factorial of
#    a number using both recursive and iterative approaches

# 4. Create a function that simulates a simple calculator
#    (add, subtract, multiply, divide) with error handling

# 5. Write a function that finds common elements between
#    two vectors using loops



















# Solutions to Additional Practice:

# 1. Prime Number Check
is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  if (n %% 2 == 0) return(FALSE)
  
  for (i in 3:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

# 2. String Reverse
reverse_string <- function(str) {
  chars <- strsplit(str, "")[[1]]
  reversed <- character(length(chars))
  for (i in 1:length(chars)) {
    reversed[i] <- chars[length(chars) - i + 1]
  }
  paste(reversed, collapse = "")
}

# 3. Factorial Calculation
# Recursive approach
factorial_recursive <- function(n) {
  if (n <= 1) return(1)
  return(n * factorial_recursive(n - 1))
}

# Iterative approach
factorial_iterative <- function(n) {
  result <- 1
  for (i in 1:n) {
    result <- result * i
  }
  return(result)
}

# 4. Simple Calculator
calculator <- function(x, y, operation = "+") {
  if (!is.numeric(x) || !is.numeric(y)) {
    return("Error: Inputs must be numeric")
  }
  
  result <- switch(operation,
                   "+" = x + y,
                   "-" = x - y,
                   "*" = x * y,
                   "/" = if(y != 0) x / y else "Error: Division by zero",
                   "Error: Invalid operation"
  )
  return(result)
}

# 5. Common Elements
find_common_elements <- function(vec1, vec2) {
  common <- c()
  for (item in vec1) {
    if (item %in% vec2 && !(item %in% common)) {
      common <- c(common, item)
    }
  }
  return(common)
}
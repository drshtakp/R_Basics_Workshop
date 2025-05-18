# =====================================================================
# STATISTICAL ANALYSIS IN R
# Purpose: Learn and implement various statistical methods
# Topics: Descriptive Stats, Hypothesis Testing, Regression, ML Intro
# =====================================================================

# Install and load required packages
# dplyr: For data manipulation and summarization
# caret: For machine learning workflows
# ggplot2: For creating visualizations
# MASS: For additional statistical functions and datasets
if (!require(caret)) install.packages("caret")
library(dplyr)    # Provides data manipulation functions like group_by(), summarize()
library(caret)    # Comprehensive framework for machine learning in R
library(ggplot2)  # Grammar of Graphics plotting system
library(MASS)     # Modern Applied Statistics functions and datasets

# =====================================================================
# PART 1: DESCRIPTIVE STATISTICS
# Purpose: Understand central tendency and spread of data
# =====================================================================

# Load and examine the mtcars dataset
# mtcars: Built-in R dataset containing car performance metrics from 1974
# Variables include: mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb
data(mtcars)

# Get comprehensive summary statistics for all variables
# summary() provides:
# - Min and Max values: Range of the data
# - 1st and 3rd quartiles: Shows data spread
# - Median: Middle value (50th percentile)
# - Mean: Average value
# - Count of NA values (if any exist)
summary(mtcars)

# Calculate detailed descriptive statistics for MPG (Miles per Gallon)
# Creating a list of various statistical measures to understand the MPG distribution
mpg_stats <- list(
  # Measures of Central Tendency
  mean = mean(mtcars$mpg),       # Average MPG - sum of all values divided by count
  median = median(mtcars$mpg),   # Middle value when data is ordered
  
  # Measures of Spread/Dispersion
  sd = sd(mtcars$mpg),          # Standard deviation - average distance from mean
  var = var(mtcars$mpg),        # Variance - square of standard deviation
  range = range(mtcars$mpg),    # Minimum and maximum values
  iqr = IQR(mtcars$mpg),        # Interquartile range - difference between 75th and 25th percentiles
  
  # Distribution Characteristics
  quartiles = quantile(mtcars$mpg)  # 0%, 25%, 50%, 75%, 100% points
)

# Display the calculated statistics for MPG
print(mpg_stats)

# Group-wise statistics using dplyr
# Purpose: Compare statistics across different groups (cylinders)
# This helps understand how MPG and weight vary by number of cylinders
mtcars %>%
  # Group the data by number of cylinders (4, 6, or 8)
  group_by(cyl) %>%                
  # Calculate summary statistics for each cylinder group
  summarise(
    count = n(),                   # Number of cars in each cylinder group
    mean_mpg = mean(mpg),         # Average MPG for each group
    sd_mpg = sd(mpg),             # Spread of MPG within each group
    mean_wt = mean(wt),           # Average weight for each group
    sd_wt = sd(wt)                # Spread of weight within each group
  )

# NOTE: Keep in mind the Law of Large Numbers and Central Limit Theorem when designing the experiment

# =====================================================================
# PART 2: T-TESTS AND ANOVA
# Purpose: Statistical hypothesis testing for comparing means
# =====================================================================

# ONE-SAMPLE T-TEST
# Purpose: Test if the population mean differs from a hypothesized value
# Null Hypothesis (H0): Population mean equals 20
# Alternative Hypothesis (Ha): Population mean differs from 20
one_sample_test <- t.test(mtcars$mpg, mu = 20)
print(one_sample_test)
# Interpretation:
# 1. Look at p-value:
#    - If p < 0.05: Reject H0 (mean is significantly different from 20)
#    - If p >= 0.05: Fail to reject H0 (insufficient evidence)
# 2. Check confidence interval:
#    - Does it contain the hypothesized value (20)?
# 3. Look at sample mean vs hypothesized value

# INDEPENDENT TWO-SAMPLE T-TEST
# Purpose: Compare means between two independent groups
# Testing: Does MPG differ between automatic (am=0) and manual (am=1) transmission?
two_sample_test <- t.test(mpg ~ am, data = mtcars)
print(two_sample_test)
# Interpretation:
# 1. Check p-value for significance
# 2. Look at mean difference
# 3. Examine confidence interval of the difference
# 4. Consider practical significance vs statistical significance

# PAIRED T-TEST EXAMPLE
# Purpose: Compare means between paired/matched observations
# Creating synthetic paired data for demonstration
set.seed(123)  # Set random seed for reproducibility
before <- rnorm(30, mean = 10, sd = 2)  # Generate "before" measurements
after <- before + rnorm(30, mean = 2, sd = 1)  # Generate "after" measurements
paired_test <- t.test(before, after, paired = TRUE)
print(paired_test)
# Interpretation:
# 1. p-value indicates if change is significant
# 2. Mean difference shows magnitude of change
# 3. Confidence interval shows plausible range of true difference

# ONE-WAY ANOVA
# Purpose: Compare means across multiple (>2) groups
# Testing: Does MPG differ among cars with different numbers of cylinders?
anova_result <- aov(mpg ~ factor(cyl), data = mtcars)
summary(anova_result)
# Interpretation:
# 1. F-statistic tests overall difference between groups
# 2. p-value indicates if there are any significant differences
# 3. Multiple R-squared shows proportion of variance explained

# POST-HOC TEST (TUKEY'S HSD)
# Purpose: Determine which specific groups differ
# Only performed if ANOVA is significant  
tukey_result <- TukeyHSD(anova_result)
print(tukey_result)
# Interpretation:
# 1. Look at p-adjusted values for each comparison
# 2. Confidence intervals show range of differences
# 3. If interval contains 0, difference is not significant

# =====================================================================
# PART 3: LINEAR REGRESSION
# Purpose: Model relationships between variables
# Key concepts: Prediction, correlation, causation
# =====================================================================

# SIMPLE LINEAR REGRESSION
# Purpose: Model relationship between two continuous variables
# Example: Predict MPG based on car weight
simple_model <- lm(mpg ~ wt, data = mtcars)
summary(simple_model)
# Interpretation of summary():
# 1. Coefficients:
#    - Intercept: Expected MPG when weight is 0
#    - wt: Change in MPG for each unit increase in weight
# 2. R-squared: Proportion of variance explained by model
# 3. F-statistic: Tests if model is better than intercept-only model
# 4. p-value: Statistical significance of the model

# Visualize the regression relationship
# This plot shows the data points and fitted line
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +                    # Add data points
  geom_smooth(method = "lm",        # Add regression line
              se = TRUE) +           # Include standard error bands
  labs(title = "MPG vs Weight",     # Add informative labels
       x = "Weight (1000 lbs)",
       y = "Miles per Gallon")

# MULTIPLE LINEAR REGRESSION
# Purpose: Predict outcome using multiple predictors
# Example: Predict MPG using weight and horsepower
multiple_model <- lm(mpg ~ wt + hp, data = mtcars)
summary(multiple_model)
# Interpretation:
# 1. Each coefficient represents effect while holding others constant
# 2. Compare R-squared with simple regression
# 3. Check significance of each predictor
# 4. Look for potential multicollinearity

# MODEL WITH INTERACTION TERMS
# Purpose: Account for variables affecting each other's relationships
# Example: Weight's effect on MPG might depend on horsepower
interaction_model <- lm(mpg ~ wt * hp, data = mtcars)
summary(interaction_model)
residuals(interaction_model)
fitted(interaction_model, data = mtcars)
predict(interaction_model, data = mtcars)
# Interpretation:
# 1. Main effects: wt and hp coefficients
# 2. Interaction effect: wt:hp coefficient
# 3. Compare R-squared with additive model
# 4. Check if interaction is significant

# MODEL DIAGNOSTICS
# Purpose: Check if regression assumptions are met
par(mfrow = c(2,2))  # Set up 2x2 plot layout
plot(multiple_model)  # Create diagnostic plots
par(mfrow = c(1,1))  # Reset plot layout
# Interpretation of diagnostic plots:
# 1. Residuals vs Fitted: Check linearity
# 2. Normal Q-Q: Check normality of residuals
# 3. Scale-Location: Check homoscedasticity
# 4. Residuals vs Leverage: Identify influential points

# =====================================================================
# PART 4: LOGISTIC REGRESSION
# Purpose: Model binary outcomes
# Example: Predict probability of categorical outcomes
# =====================================================================

# Create binary outcome variable
# Classify cars as 'efficient' (1) or 'not efficient' (0) based on median MPG
mtcars$efficient <- as.factor(ifelse(mtcars$mpg > median(mtcars$mpg), 1, 0))

# Fit logistic regression model
# Predict efficiency using weight and horsepower
logistic_model <- glm(efficient ~ wt + hp, 
                      data = mtcars, 
                      family = binomial(link = "logit"))
summary(logistic_model)
# Interpretation:
# 1. Coefficients are in log-odds scale
# 2. Use exp(coef) for odds ratios
# 3. Null deviance vs Residual deviance
# 4. AIC for model comparison

# Calculate odds ratios
# Convert log-odds to more interpretable odds ratios
odds_ratios <- exp(coef(logistic_model))
print(odds_ratios)
# Interpretation:
# - Values > 1: Increased odds of being efficient
# - Values < 1: Decreased odds of being efficient
# - Example: OR of 0.5 means 50% decrease in odds

# Generate predicted probabilities
# Convert model predictions to probabilities
predicted_probs <- predict(logistic_model, type = "response")
head(predicted_probs)
# Interpretation:
# - Values are probabilities (0 to 1)
# - Can use 0.5 as default threshold
# - Higher threshold = more specific
# - Lower threshold = more sensitive
floor(predicted_probs+0.5)

# =====================================================================
# PART 5: INTRODUCTION TO MACHINE LEARNING
# Purpose: Predictive modeling with validation
# =====================================================================

# Data Preparation
# Split data into training (70%) and testing (30%) sets
set.seed(123)  # Set seed for reproducibility
trainIndex <- createDataPartition(mtcars$mpg, p = .7, list = FALSE)
training <- mtcars[trainIndex,]    # Training dataset
testing <- mtcars[-trainIndex,]    # Testing dataset

# Create training control parameters
# Define how model will be evaluated
train_control <- trainControl(
  method = "cv",          # Use cross-validation
  number = 5              # 5-fold cross-validation
)
# Cross-validation:
# 1. Splits training data into 5 parts
# 2. Trains on 4 parts, validates on 1
# 3. Repeats 5 times with different splits
# 4. Averages results for robust evaluation

# Train linear regression model using caret
# More sophisticated approach than basic lm()
caret_model <- train(
  mpg ~ wt + hp,                   # Formula: predict MPG from weight and horsepower
  data = training,                 # Use training data only
  method = "lm",                   # Linear regression model
  trControl = train_control        # Use defined training control
)

# Model results
print(caret_model)
# Interpretation:
# 1. RMSE: Average prediction error
# 2. R-squared: Variance explained
# 3. MAE: Mean absolute error
# 4. Cross-validation results

# Make predictions on test set
predictions <- predict(caret_model, testing)

# Calculate performance metrics
# Root Mean Square Error (RMSE)
rmse <- sqrt(mean((testing$mpg - predictions)^2))
# R-squared (coefficient of determination)
r2 <- cor(testing$mpg, predictions)^2

# Print performance metrics
cat("RMSE:", rmse, "\n")  # Lower RMSE indicates better fit
cat("R-squared:", r2, "\n")  # Higher R-squared indicates better fit

# =====================================================================
# EXERCISES AND PRACTICE
# Purpose: Apply learned concepts through hands-on examples
# Topics: All previous statistical methods with practical applications
# =====================================================================

# =====================================================================
# EXERCISE 1: COMPREHENSIVE DESCRIPTIVE STATISTICS
# Purpose: Practice data summarization and exploration
# =====================================================================

# Calculate summary statistics for each numeric variable in mtcars
# Using dplyr's across() function to apply multiple summaries
numeric_summary <- mtcars %>%
  summarise(across(
    where(is.numeric),    # Select all numeric columns
    list(
      mean = ~mean(.),    # Calculate mean
      sd = ~sd(.),        # Calculate standard deviation
      median = ~median(.) # Calculate median
    ),
    .names = "{.col}_{.fn}"  # Name format: variable_statistic
  ))

# Print results
print(numeric_summary)
# Interpretation tips:
# 1. Compare mean and median to assess skewness
# 2. Look at sd relative to mean for variability
# 3. Identify variables with unusual patterns

# Visual exploration of distributions
# Create histograms for key variables
par(mfrow = c(2,2))  # Set up 2x2 plot layout
hist(mtcars$mpg, main="MPG Distribution", xlab="Miles Per Gallon")
hist(mtcars$wt, main="Weight Distribution", xlab="Weight (1000 lbs)")
hist(mtcars$hp, main="Horsepower Distribution", xlab="Horsepower")
hist(mtcars$disp, main="Displacement Distribution", xlab="Displacement")
par(mfrow = c(1,1))  # Reset plot layout

# =====================================================================
# EXERCISE 2: ADVANCED HYPOTHESIS TESTING
# Purpose: Practice various statistical tests
# =====================================================================

# Test if cars with manual transmission have different horsepower
# than cars with automatic transmission
hp_test <- t.test(hp ~ am, data = mtcars)
print(hp_test)
# Analysis steps:
# 1. Check p-value for significance
# 2. Examine mean difference
# 3. Look at confidence interval
# 4. Consider practical implications

# Multi-group comparison of horsepower across cylinder groups
# Using one-way ANOVA
hp_anova <- aov(hp ~ factor(cyl), data = mtcars)
summary(hp_anova)
# Follow-up analysis:
TukeyHSD(hp_anova)
# Interpretation:
# 1. Overall ANOVA significance
# 2. Specific group differences
# 3. Effect sizes

# =====================================================================
# EXERCISE 3: COMPREHENSIVE REGRESSION ANALYSIS
# Purpose: Build and evaluate multiple regression models
# =====================================================================

# Model predicting quarter-mile time (qsec)
# Using multiple predictors
qsec_model <- lm(qsec ~ wt + hp + am, data = mtcars)
summary(qsec_model)

# Model diagnostics
# Create comprehensive diagnostic plots
par(mfrow = c(2,2))
plot(qsec_model)
par(mfrow = c(1,1))

# Calculate VIF (Variance Inflation Factor) for multicollinearity
# Install and load car package if needed
if (!require(car)) install.packages("car")
library(car)
vif(qsec_model)
# Interpretation:
# - VIF > 5 indicates potential multicollinearity
# - VIF > 10 indicates serious multicollinearity

# =====================================================================
# EXERCISE 4: ADVANCED LOGISTIC REGRESSION
# Purpose: Binary classification with multiple predictors
# =====================================================================

# Predict transmission type (am) based on car features
# Create comprehensive model with multiple predictors
am_model <- glm(am ~ wt + hp + mpg, 
                data = mtcars, 
                family = binomial(link = "logit"))

# Model summary and interpretation
summary(am_model)

# Calculate and interpret odds ratios
odds_ratios <- exp(coef(am_model))
conf_intervals <- exp(confint(am_model))
# Combine results
odds_ratio_table <- data.frame(
  OR = odds_ratios,
  CI_lower = conf_intervals[,1],
  CI_upper = conf_intervals[,2]
)
print(odds_ratio_table)

# Assess model fit
# Calculate pseudo R-squared (McFadden's)
null_model <- glm(am ~ 1, data = mtcars, family = binomial)
mcfadden_r2 <- 1 - (logLik(am_model)/logLik(null_model))
print(paste("McFadden R-squared:", mcfadden_r2))

# =====================================================================
# EXERCISE 5: MACHINE LEARNING APPLICATION
# Purpose: Advanced predictive modeling
# =====================================================================

# Use random forest to predict MPG
# Install required package
if (!require(randomForest)) install.packages("randomForest")
library(randomForest)

# Create training control with cross-validation
train_control <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

# Train random forest model
rf_model <- train(
  mpg ~ .,                    # Use all variables to predict MPG
  data = training,            # Use training dataset
  method = "rf",              # Random Forest algorithm
  trControl = train_control,  # Use defined training control
  importance = TRUE           # Calculate variable importance
)

# Model evaluation
print(rf_model)

# Variable importance
importance <- varImp(rf_model)
plot(importance)

# Make predictions on test set
rf_predictions <- predict(rf_model, testing)

# Calculate performance metrics
rf_rmse <- sqrt(mean((testing$mpg - rf_predictions)^2))
rf_r2 <- cor(testing$mpg, rf_predictions)^2

# Compare with linear model performance
cat("Random Forest RMSE:", rf_rmse, "\n")
cat("Random Forest R-squared:", rf_r2, "\n")

# =====================================================================
# BONUS EXERCISE: MODEL COMPARISON
# Purpose: Compare different modeling approaches
# =====================================================================

# Create comparison table of different models
# 1. Simple linear regression
# 2. Multiple linear regression
# 3. Random forest
# Store all predictions and actual values
results_df <- data.frame(
  Actual = testing$mpg,
  Linear = predict(simple_model, testing),
  Multiple = predict(multiple_model, testing),
  RandomForest = rf_predictions
)

# Calculate performance metrics for each model
models_comparison <- data.frame(
  Model = c("Simple Linear", "Multiple Linear", "Random Forest"),
  RMSE = c(
    sqrt(mean((results_df$Actual - results_df$Linear)^2)),
    sqrt(mean((results_df$Actual - results_df$Multiple)^2)),
    sqrt(mean((results_df$Actual - results_df$RandomForest)^2))
  ),
  R2 = c(
    cor(results_df$Actual, results_df$Linear)^2,
    cor(results_df$Actual, results_df$Multiple)^2,
    cor(results_df$Actual, results_df$RandomForest)^2
  )
)

# Print comparison results
print(models_comparison)
# Interpretation:
# 1. Compare RMSE values (lower is better)
# 2. Compare R-squared values (higher is better)
# 3. Consider model complexity vs. performance
# 4. Think about practical implications of each model
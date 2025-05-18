# What is Data Visualization? It's an essential skill for Data Science
# It combines Statistics and Design in a meaningful way to tell a story.

# In one way - it's a graphical interpretation to show/work on data analysis
# Also used to better understand the results as it gives a clear understanding about what's 
#happening

# Difference between Explanatory and Exploratory 
# Explanatory is for a wider audience where as exploratory is for a small set of audience
if (!require(ggridges)) install.packages("ggridges")
library(ggplot2)
library(MASS)
mammals # Let's start with a general example about what we'll be doing today

# This dataset contains the average bodyweight and brain weight of the mammals

# To understand the relationship we can always start with a scatterplot

ggplot(mammals, aes(x=body,y=brain))+ geom_point()

# We can see from the scatterplot that it is positive skewed

# Let's try to change it to a log scale and fit a regression line
ggplot(mammals, aes(x=body, y= brain))+ geom_point(alpha=0.5)+ 
  stat_smooth(method= "lm", se = FALSE, color="red")

# alpha is for the opacity of the points - usually varies from 0 to 1

# For this dataset, applying a linear model is a poor choice because of the outliers

ggplot(mammals, aes(x=body, y= brain))+ geom_point(alpha=0.9) +
  scale_x_log10()+scale_y_log10() + stat_smooth(method ="lm" , color="green",
                                                se = FALSE)
# After the log transformation we can see that the regression line (linear model) 
# is a good choice

# That's the reason we cannot always depend on the numerical data to make our conclusion
# Show the graph with all the graphs



# Let's start with playing around with the "mtcars" dataset

mtcars

?mtcars # if you want help with the dataset

# if you want to explore more about the dataset
str(mtcars) # gives you information about each column and what type of data is in it

ggplot(mtcars, aes(cyl, mpg)) +
  geom_point() # create a scatterplot of cyl = NUmber of cylinders against mpg = miles/gallon

# The plot from the previous question wasn't really satisfying. 
# Although cyl (the number of cylinders) is categorical(only 4,6,8), you probably noticed 
# that it is classified as numeric in mtcars. This is really misleading because the 
# representation in the plot doesn't match the actual data type. 

ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_point() # running the ggplot as a factor


# Grammar of the graphics: It is based on the plotting framework and it depends on two things:
# a) graphics is made of distinct layers of grammatical elements and 
# b) Meaningful plots are built around appropriate aesthetics 


# Let's explore grammatical elements first: There are three major things
# a) Data : The dataset that is being plotted
# b) Aesthetics : The scale onto which we map our data
# c) Geometries : The visual elements used for the data

# Other minor elements:
# a) Themes : allows you to exercise fine control over the non-data elements of your plot
# b) Statistics : to understand the data
# c) Coordinates : The space where the data will be plotted
# d) Facets : if we need small multiples of the plots ( Multiple plots - like scatterplot)

ggplot(mtcars, aes(wt, mpg)) + geom_point() # simple scatterplot bw wt and mpg

ggplot(mtcars, aes(wt, mpg, color = disp)) +
  geom_point() # using color aesthetic to show one more feature of that dataset in the plot 

# What if we to experiment a little bit and also see the size for the displacement 
ggplot(mtcars, aes(wt, mpg, size = disp)) +
  geom_point()

#These are two different ways to convey information about the third variable in scatterplot

# There is an another argument that we can use : shape
ggplot(mtcars, aes(wt, mpg, shape = disp)) +
  geom_point() # shape cannot be applied to a continuous variable

ggplot(mtcars, aes(wt, mpg, shape = factor(cyl))) +
  geom_point() # it runs because it's a categorical variable

# Let's combine displacement as well here
ggplot(mtcars, aes(wt, mpg, shape = factor(cyl), color = disp)) +
  geom_point()

# Also, if we want o see size of each item

ggplot(mtcars, aes(wt, mpg, shape = factor(cyl), size = disp)) +
  geom_point()



# Part 2 - A new dataset - Diamonds
# The diamonds data frame contains information on the prices and various metrics of 50,000 
# diamonds. Among the variables included are carat (a measurement of the size of the diamond)
# and price. We'll be using a subset of 1,000 diamonds.

# Explore the diamonds data frame with str()
str(diamonds)

ggplot(diamonds, aes(x = carat, y = price))+
  geom_point() # scatterplot of carat with price

# Add geom_point() and geom_smooth() 

ggplot(diamonds, aes(x = carat, y = price))+
  geom_point() + geom_smooth()

# 2 - show only the smooth line
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_smooth()

# 3 - col in aes()
ggplot(diamonds, aes(x = carat, y = price, color=clarity)) +
  geom_smooth() # clarity = ordered factor with eight levels


# We can also create objects in which we can store the plots and add things/features to them
# later on and we can add any number of features to them

# Draw a ggplot
plt_price_vs_carat <- ggplot(diamonds, aes(x= carat, y=price))

plt_price_vs_carat # nothing is gonna happen because we're not using geom_point to see
# the scatterplot

# Add a point layer ( geom_point) to plt_price_vs_carat
plt_price_vs_carat + geom_point()

plt_price_vs_carat <- ggplot(diamonds, aes(carat, price))

# To make points 20% opaque: plt_price_vs_carat_transparent
plt_price_vs_carat_transparent <- plt_price_vs_carat + geom_point(alpha = 0.2)

# See the plot
plt_price_vs_carat_transparent

# From previous step
plt_price_vs_carat <- ggplot(diamonds, aes(carat, price))

# To map color to clarity,
# Assign the updated plot to a new object
plt_price_vs_carat_by_clarity <- plt_price_vs_carat + geom_point(aes(color = clarity))

# See the plot
plt_price_vs_carat_by_clarity




# Next part is to explore Aesthetics:

# typical visible aesthetics are:
# x = the x-axis ; y= the y-axis
# fill = Fill color
# color = color of the points
# size = thickness ( radius of the points) or size of the line
# alpha = transparency
# linetype = line pattern of the line
# labels = text on a plot or the axes
# shape = shape of the points if they are not continuous

ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
  # Set the shape and size of the points
  geom_point(shape = 2, size = 3)

ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
  # Set the shape and size of the points
  geom_point(shape = 3, size = 3)


# Map fcyl to fill
ggplot(mtcars, aes(wt, mpg, fill = factor(cyl))) +
  geom_point(shape = 1, size = 4) # check again

#The default geom_point() uses shape = 19: a solid circle. 
#An alternative is shape = 21: a circle that allow you to use both fill for the inside and 
#color for the outline.

ggplot(mtcars, aes(wt, mpg, fill = factor(cyl))) +
  # Change point shape; set alpha
  geom_point(shape = 21, size = 4, alpha = 0.6)

# Map color to fam = factor of am
ggplot(mtcars, aes(wt, mpg, fill = factor(cyl), color = factor(am))) +
  geom_point(shape = 21, size = 4, alpha = 0.6)



# Exercise
# Using mtcars, create a plot base layer, plt_mpg_vs_wt. Map mpg onto y and wt onto x.
# Add a point layer, mapping the categorical no. of cylinders, fcyl, onto size.

# Establish the base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))

# Map fcyl to size
plt_mpg_vs_wt +
  geom_point(aes(size = factor(cyl))) 

# Change the mapping. This time fcyl should be mapped onto alpha

# Base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))

# Map fcyl to alpha, not size
plt_mpg_vs_wt +
  geom_point(aes(alpha = factor(cyl)))


#Change the mapping again. This time fycl should be mapped onto shape

# Base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))

# Map fcyl to shape
plt_mpg_vs_wt +
  geom_point(aes(shape = factor(cyl)))


#Swap the geom layer: change points to text.
#Change the mapping again. This time fycl should be mapped onto label

# Base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))

# Use text layer and map fcyl to label
plt_mpg_vs_wt +
  geom_text(aes(label = factor(cyl)))





# Updating aesthetic labels

#We'll modify some aesthetics to make a bar plot of the number of cylinders for cars with 
# different types of transmission.

# We'll also make use of some functions for improving the appearance of the plot.

#labs() to set the x- and y-axis labels. It takes strings for each argument.

ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  geom_bar() +
  # Set the axis labels
  labs(x = "Number of Cylinders", y = "Count")


# Set the position
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  geom_bar(position = 'dodge') +
  labs(x = "Number of Cylinders", y = "Count")




# Geometries : how the plot actually looks

# There are 48 geom_* in R
# You can look at the link if you're interested in it:
# https://ggplot2.tidyverse.org/reference/

# Each geom serves a specific purpose and it's upto you to decide which one will be the best
# for your dataset

# Let's take scatterplot for example : X and y axis are important for geom_point()
# Otherwise we won't be able to draw a scatterplot. Others are optional

# Like - alpha, color,fill,shape,size or stroke

# You can pass the aesthetics in geom or ggplot

# We'll play around with a new dataset by the name of "iris"

# load the dataset
iris

?iris # info about iris

str(iris) # other detail information about the dataset

# For example: these two commands gives you the same plot
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species))+ geom_point()

# Or/And
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point(aes(col=Species))


# Now, we can use different geom_ to add more information : like the mean or something else
# Example:

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species)) + geom_point()

#if we want to add other information we can use another geom_point on top of it to add one 
# more layer

#Let's say we're interested in the means
# Load library(dplyr) first to use "pipes"
iris %>%
  group_by(Species)%>%
  summarise_all(mean) ->iris.summary

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species))+ 
  geom_point() +geom_point(data = iris.summary, shape =15 , size =5)

# There are 25 different shapes that we can use. I'll show some examples
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species))+ 
  geom_point() +geom_point(data = iris.summary, shape =5 , size =5)

# Another way of showing the same thing using stroke(thick outline)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species))+ 
  geom_point() +geom_point(data = iris.summary, shape =21 , size =5, fill="black",stroke =1)




# How to handle overplotting:

# There are different cases in overplotting:
# 1 A large dataset

# How to deal with large dataset like diamonds which has over 50,000 points

# Plot price vs. carat, colored by clarity
plt_price_vs_carat_by_clarity <- ggplot(diamonds, aes(carat, price, color = clarity))

# Add a point layer with tiny points
plt_price_vs_carat_by_clarity + geom_point(alpha = 0.5)


# Plot price vs. carat, colored by clarity
plt_price_vs_carat_by_clarity <- ggplot(diamonds, aes(carat, price, color = clarity))

# Add a point layer with tiny points
plt_price_vs_carat_by_clarity + geom_point(alpha = 0.5, shape = ".")


# 2 Overplotting 2: Aligned values
# This occurs when one axis is continuous and the other is categorical

# Plot base
plt_mpg_vs_fcyl_by_fam <- ggplot(mtcars, aes(factor(cyl), mpg, color = factor(am)))

# Default points are shown for comparison
plt_mpg_vs_fcyl_by_fam + geom_point()

# How to deal with it - use jittering

# Alter the point positions by jittering, width 0.3
plt_mpg_vs_fcyl_by_fam + geom_point(position = position_jitter(width = 0.2))

# But we get different results every time we run this line. How do we fix this?

# What is the use of jittering?
# The jitter geom is a convenient shortcut for geom_point(position = "jitter") . 
# It adds a small amount of random variation to the location of each point, and is a useful 
# way of handling overplotting caused by discreteness in smaller datasets.


# Another way to use Jitter

plt_mpg_vs_fcyl_by_fam + 
  geom_point(position = position_jitterdodge(jitter.width = 0.3, dodge.width = 0.3))


# Histograms

ggplot(iris, aes(x=Sepal.Width)) + geom_histogram()

ggplot(iris, aes(x=Sepal.Width)) + geom_histogram(binwidth = 0.1) # more intuitive
# As there is no space it shows that it is continuous variable


# If you remember we have three different species in our dataset iris
ggplot(iris, aes(x=Sepal.Width, fill=Species)) + geom_histogram(binwidth = 0.1)

ggplot(iris, aes(x=Sepal.Width, fill=Species)) + geom_histogram(binwidth = 0.1, center = 0.05)
# to add the x-label in the centre

# By looking at the histogram whether the Species are overlapping or stacked

# We can play with it and have different ways to represent the same thing
ggplot(iris, aes(x=Sepal.Width, fill=Species)) + 
  geom_histogram(binwidth = 0.1,position="dodge") # side by side

ggplot(iris, aes(x=Sepal.Width, fill=Species)) + 
  geom_histogram(binwidth = 0.1,position="stack") # over top of each other

# default is "stack"

# Another Example

light_blue <- "#51A8C9"

# An internal variable called density can be accessed by using the .. notation, 
#i.e. ..density.. Plotting this variable will show the relative frequency, which is the 
# height times the width of each bin.

ggplot(mtcars, aes(mpg, ..density..)) +
  # Set the fill color to light_blue
  geom_histogram(binwidth = 1, fill = light_blue)


# Bar plots :

# geom_bar = used for count - to count total values
# geom_col = to plot actual values

# Plot fcyl, filled by fam
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Add a bar layer
  geom_bar()

ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Change the position to "dodge"
  geom_bar(position = "fill") #  proportion - gives you 100 percent

ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Change the position to "dodge"
  geom_bar(position = "dodge") # side by side

# Overlapping bar plots
ggplot(mtcars, aes(cyl, fill = factor(am))) +
  # Change position to use the functional form, with width 0.2
  geom_bar(position = position_dodge(width = 0.9))

ggplot(mtcars, aes(cyl, fill = factor(am))) +
  # Set the transparency to 0.6
  geom_bar(position = position_dodge(width = 0.2), alpha = 0.6)


# Bar plots: sequential color palette
# In this bar plot, we'll fill each segment according to an ordinal variable. 
# The best way to do that is with a sequential color palette.

ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")


# Line plots:usually used in time series

#Here, we'll use the economics dataset to make some line plots. The dataset contains a time 
#series for unemployment and population statistics from the Federal Reserve Bank of St. Louis
# in the United States. The data is contained in the ggplot2 package.

# Print the head of economics
head(economics)

# Using economics, plot unemploy vs. date
ggplot(economics, aes(date, unemploy)) +
  # Make it a line plot
  geom_line()


# Let's see how we can combine these plots with statistics and some other things to get more
# information

# View the structure of mtcars
str(mtcars)

# Using mtcars, draw a scatter plot of mpg vs. wt
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Amend the plot to add a smooth layer
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth()

# Amend the plot. Use lin. reg. smoothing; turn off std err ribbon
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) # used when we have less than 1000 points

# Amend the plot. Swap geom_smooth() for stat_smooth().
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE)


# Using mtcars, plot mpg vs. wt, colored by fcyl
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  # Add a point layer
  geom_point() +
  # Add a smooth lin. reg. stat, no ribbon
  stat_smooth(method = "lm", se = FALSE)


# Update the plot to add a second smooth stat.
#Add a dummy group aesthetic to this layer, setting the value to 1.
#Use the same method and se values as the first stat smooth layer.

# Amend the plot to add another smooth layer with dummy grouping
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  stat_smooth(aes(group = 1), method = "lm", se = FALSE)


#Modifying stat_smooth

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add 3 smooth LOESS stats, varying span & color
  stat_smooth(se = FALSE, color = "red", span = 0.9) +
  stat_smooth(se = FALSE, color = "green", span = 0.6) +
  stat_smooth(se = FALSE, color = "blue", span = 0.3)


# Amend the plot to color by fcyl
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  # Add a smooth LOESS stat, no ribbon
  stat_smooth(se = FALSE) +
  # Add a smooth lin. reg. stat, no ribbon
  
  
# Statistical Transformations
  # Scatter plot with mean line
  ggplot(mtcars, aes(hp, mpg)) + 
  geom_point(color = "blue") +
  stat_summary(fun.y = "mean", geom = "line", linetype = "dashed")
# This creates a scatter plot of mpg vs hp, with a dashed line representing the mean mpg for each hp value

# Scatter plot with rug plot
ggplot(mtcars, aes(hp, mpg)) + 
  geom_point(color = "blue") + 
  geom_rug(show.legend = FALSE) +
  stat_summary(fun.y = "mean", geom = "line", linetype = "dashed")
# This adds a rug plot (small lines on the axes showing the distribution of points) to the previous plot

# Histogram
ggplot(mtcars, aes(x=mpg)) + geom_histogram()
# This creates a histogram showing the distribution of mpg values

# Box Plot
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + geom_boxplot()
# This creates a box plot showing the distribution of mpg for each cylinder count

# Box Plot with custom colors
mtcars$cyl <- as.factor(mtcars$cyl)  # Convert 'cyl' to a factor for better plotting
ggplot(mtcars, aes(x=(cyl), y=mpg, color = cyl)) + 
  geom_boxplot() +
  scale_color_manual(values = c("#3a0ca3", "#c9184a", "#3a5a40"))
# This creates a box plot with custom colors for each cylinder count

# Violin Plot
ggplot(mtcars, aes(factor(cyl), mpg)) + geom_violin(aes(fill = cyl))
# This creates a violin plot showing the distribution of mpg for each cylinder count

# Pie Chart
ggplot(mtcars, aes(x="", y=mpg, fill=cyl)) + 
  geom_bar(stat="identity", width=1) + 
  coord_polar("y", start=0)
# This creates a pie chart showing the proportion of total mpg for each cylinder count

# Polar Plot
mtcars %>%
  group_by(cyl) %>%
  summarize(mpg = median(mpg)) %>%
  ggplot(aes(x = cyl, y = mpg)) + 
  geom_col(aes(fill = cyl), color = NA) + 
  labs(x = "", y = "Median mpg") + 
  coord_polar()
# This creates a polar plot showing the median mpg for each cylinder count

# Bump Chart
ggplot(mtcars, aes(x = hp, y = mpg, group = cyl)) + 
  geom_line(aes(color = cyl), size = 2) + 
  geom_point(aes(color = cyl), size = 4) + 
  scale_y_reverse(breaks = 1:nrow(mtcars))
# This creates a bump chart showing how mpg changes with hp for each cylinder count

# Contour Plot
# A 2D density contour plot shows the estimated density of points in 2D space
ggplot(mtcars, aes(mpg, hp)) + 
  geom_density_2d_filled(show.legend = FALSE) + 
  coord_cartesian(expand = FALSE) + 
  labs(x = "mpg")
# This creates a filled contour plot of the density of points in the mpg-hp space

# Scatter plot with contour lines
ggplot(mtcars, aes(x = mpg, y = hp)) + 
  geom_point() + 
  geom_density_2d()
# This adds contour lines to a scatter plot, showing both individual points and their density

# Heatmap
# Heatmaps show the density of points using color
ggplot(iris, aes(Sepal.Length, Petal.Length)) + 
  geom_hex(bins = 20, color = "grey") + 
  scale_fill_distiller(palette = "Spectral", direction = 1)
# This creates a hexagonal heatmap of Sepal.Length vs Petal.Length

# Alternative heatmap with rectangular bins
ggplot(iris, aes(Sepal.Length, Petal.Length)) + 
  geom_bin2d(bins = 15) + 
  scale_fill_distiller(palette = "Spectral", direction = 1)
# This creates a rectangular heatmap of Sepal.Length vs Petal.Length

# Ridge Plot
# Ridge plots show the distribution of a numeric variable for different categories
library(ggridges)
ggplot(iris, aes(x = Sepal.Length, y = Species)) + 
  geom_density_ridges(fill = "gray90")
# This creates a ridge plot showing the distribution of Sepal.Length for each Species

# Ridge plot with gradient fill
ggplot(iris, aes(x = Sepal.Length, y = Species, fill = stat(x))) + 
  geom_density_ridges_gradient() + 
  scale_fill_viridis_c(name = "Depth", option = "C")
# This creates a ridge plot with gradient fill based on the x-axis values

# Customization in ggplot2

# Plot Titles
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  ggtitle("hp vs mpg")
# This adds a simple title to the plot

# Adding title using labs()
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  labs(title = "hp vs mpg")
# This adds a title using the labs() function, which is more flexible for adding multiple labels

# Adding subtitle
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  ggtitle("hp vs mpg", subtitle = "Subtitle of the plot")
# This adds both a title and a subtitle to the plot

# Customizing title appearance
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  ggtitle("hp vs mpg") +
  theme(plot.title = element_text(hjust = 0, size = 16, face = "bold"))
# This customizes the appearance of the title (right-aligned, larger, bold)

# Themes
# Changing panel background color
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  theme(panel.background = element_rect(fill = "#72efdd"))
# This changes the background color of the plot panel

# Customizing panel border
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  theme(panel.border = element_rect(fill = "transparent", color = "#72efdd", size = 4))
# This adds a colored border to the plot panel

# Changing plot background color
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() +
  theme(plot.background = element_rect(fill = "#72efdd"))
# This changes the background color of the entire plot

# Grid Customization
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  theme(panel.grid = element_line(color = "#3a0ca3", size = 1, linetype = 3))
# This customizes the appearance of the grid lines

# Removing grid lines
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() +  
  theme(panel.grid = element_blank())
# This removes all grid lines from the plot

# Customizing margins
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot() + 
  theme(plot.background = element_rect(color = 1, size = 1),
        plot.margin = margin(t = 20, r = 50, b = 40, l = 30))
# This adjusts the margins around the plot

# Creating a panel of different plots
library(patchwork)
p1 <- ggplot(mtcars, aes(x = hp, y = mpg, color = gear)) + 
  geom_line(color = "#3a0ca3") + 
  geom_point() 
p2 <- ggplot(mtcars, aes(x = carb, y = mpg, color = gear)) + 
  geom_line(color = "#c9184a") + 
  geom_point() 
p1 + p2
# This creates two separate plots and combines them side-by-side using the patchwork package

# Faceting
# Facet wrap
ggplot(mtcars, aes(hp, mpg)) + 
  geom_point() +
  facet_wrap(~carb)
# This creates separate plots for each unique value in the 'carb' variable

# Facet grid
ggplot(mtcars, aes(hp, mpg)) + 
  geom_point() + 
  facet_grid(. ~ cyl) + 
  facet_grid(cyl ~ .) + 
  facet_grid(gear ~ cyl, labeller = "label_both")
# This demonstrates different ways to use facet_grid for creating grid layouts of plots
  stat_smooth(method = "lm", se = FALSE)
# Assignment #9 - Comparing Visualization Systems in R
# Base R, Lattice, and ggplot2

# Install packages if needed
if (!requireNamespace("lattice", quietly = TRUE)) {
  install.packages("lattice")
}

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

library(lattice)
library(ggplot2)

# Load the mtcars dataset from Rdatasets
data("mtcars", package = "datasets")

# Display the first six rows
head(mtcars)

# Create a cylinder group variable
mtcars$cyl_group <- factor(
  mtcars$cyl,
  levels = c(4, 6, 8),
  labels = c("4 Cylinders", "6 Cylinders", "8 Cylinders")
)


# =====================================
# PART 1: BASE R GRAPHICS
# =====================================

# Plot 1: Scatterplot of weight vs. MPG
png("base_scatter.png", width = 900, height = 600)

plot(mtcars$wt, mtcars$mpg,
     main = "Base R: Vehicle Weight vs. Fuel Efficiency",
     xlab = "Vehicle Weight (1,000 lbs)",
     ylab = "Miles Per Gallon (MPG)",
     col = "steelblue",
     pch = 19)

abline(lm(mpg ~ wt, data = mtcars),
       col = "red",
       lwd = 2)

dev.off()


# Plot 2: Histogram of MPG
png("base_histogram.png", width = 900, height = 600)

hist(mtcars$mpg,
     main = "Base R: Distribution of Vehicle MPG",
     xlab = "Miles Per Gallon (MPG)",
     ylab = "Frequency",
     col = "lightblue",
     border = "white")

dev.off()


# =====================================
# PART 2: LATTICE GRAPHICS
# =====================================

# Plot 3: Scatterplot by cylinder group
png("lattice_scatter.png", width = 1100, height = 600)

print(
  xyplot(mpg ~ wt | cyl_group,
         data = mtcars,
         main = "Lattice: Weight vs. MPG by Cylinder Group",
         xlab = "Vehicle Weight (1,000 lbs)",
         ylab = "Miles Per Gallon (MPG)",
         layout = c(3, 1),
         pch = 19,
         col = "steelblue",
         type = c("p", "r"))
)

dev.off()


# Plot 4: Boxplot of MPG by cylinder group
png("lattice_boxplot.png", width = 900, height = 600)

print(
  bwplot(mpg ~ cyl_group,
         data = mtcars,
         main = "Lattice: MPG by Cylinder Group",
         xlab = "Number of Cylinders",
         ylab = "Miles Per Gallon (MPG)",
         fill = "lightblue")
)

dev.off()


# =====================================
# PART 3: GGPLOT2 GRAPHICS
# =====================================

# Plot 5: Scatterplot with regression lines
p1 <- ggplot(mtcars,
             aes(x = wt, y = mpg,
                 color = cyl_group)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm",
              formula = y ~ x,
              se = FALSE) +
  labs(
    title = "ggplot2: Vehicle Weight vs. Fuel Efficiency",
    x = "Vehicle Weight (1,000 lbs)",
    y = "Miles Per Gallon (MPG)",
    color = "Cylinder Group"
  ) +
  theme_minimal()

print(p1)

ggsave("ggplot_scatter.png",
       plot = p1,
       width = 10,
       height = 6,
       dpi = 300)


# Plot 6: Faceted histograms
p2 <- ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(
    binwidth = 3,
    fill = "steelblue",
    color = "white"
  ) +
  facet_wrap(~ cyl_group) +
  labs(
    title = "ggplot2: MPG Distribution by Cylinder Group",
    x = "Miles Per Gallon (MPG)",
    y = "Frequency"
  ) +
  theme_minimal()

print(p2)

ggsave("ggplot_histogram.png",
       plot = p2,
       width = 10,
       height = 6,
       dpi = 300)


# =====================================
# VERIFY SAVED PLOTS
# =====================================

plot_files <- c(
  "base_scatter.png",
  "base_histogram.png",
  "lattice_scatter.png",
  "lattice_boxplot.png",
  "ggplot_scatter.png",
  "ggplot_histogram.png"
)

file.exists(plot_files)

# Display where the files were saved
getwd()

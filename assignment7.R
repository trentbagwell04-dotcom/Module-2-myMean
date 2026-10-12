
# Assignment #7: Generic Functions, S3, and S4
# Step 1: Load and inspect the mtcars dataset

data("mtcars")

# Display the first six rows
head(mtcars)

# Examine the structure of the dataset
str(mtcars)

# Check the class and underlying type
class(mtcars)
typeof(mtcars)
]
# Step 2: Test Generic Functions

# Print the dataset
print(head(mtcars))

# Generate a statistical summary
summary(mtcars)

# Create a scatterplot of MPG vs. Weight
plot(mtcars$wt, mtcars$mpg,
     main = "Relationship Between Car Weight and MPG",
     xlab = "Weight (1000 lbs)",
     ylab = "Miles Per Gallon (MPG)",
     col = "blue",
     pch = 19)

# Check available S3 methods
methods("print")
methods("summary")
methods("plot")


# Step 3: Create an S3 Object

# Create a student object
s3_obj <- list(name = "Trent", age = 22, GPA = 3.5)

# Assign an S3 class
class(s3_obj) <- "student_s3"

# Check the class and underlying type
class(s3_obj)
typeof(s3_obj)
isS4(s3_obj)

# Define a custom print method for the S3 class
print.student_s3 <- function(x, ...) {
  cat("Student Name:", x$name, "\n")
  cat("Age:", x$age, "\n")
  cat("GPA:", x$GPA, "\n")
}

# Test the generic function
print(s3_obj)


# Step 4: Create an S4 Object

# Load the methods package
library(methods)

# Define an S4 student class
setClass("student_s4",
         slots = c(name = "character",
                   age = "numeric",
                   GPA = "numeric"))


# Load the methods package
library(methods)

# Define the S4 class
setClass("student_s4",
         slots = c(name = "character",
                   age = "numeric",
                   GPA = "numeric"))

# Check that the class exists
isClass("student_s4")

# Create an S4 student object
s4_obj <- new("student_s4",
              name = "Trent",
              age = 22,
              GPA = 3.5)

# Check the class and object type
class(s4_obj)
typeof(s4_obj)
isS4(s4_obj)

# Define a custom print method for the S4 class
setMethod("show", "student_s4",
          function(object) {
            cat("Student Name:", object@name, "\n")
            cat("Age:", object@age, "\n")
            cat("GPA:", object@GPA, "\n")
          })

# Test the S4 method
show(s4_obj)

# Display the S4 class definition
getClass("student_s4")

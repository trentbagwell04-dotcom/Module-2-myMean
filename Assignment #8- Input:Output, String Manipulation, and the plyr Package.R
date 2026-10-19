# Assignment #8 - Reading and Writing Data Files

# Import the Assignment 6 dataset
student6 <- read.table(
  file.choose(),
  header = TRUE,
  sep = ",",
  stringsAsFactors = FALSE
)

# Display the dataset
student6

# Check the structure
str(student6)

# Step 2: Calculate Average Grade by Sex

# Install plyr if it is not already installed
if (!requireNamespace("plyr", quietly = TRUE)) {
  install.packages("plyr")
}

# Load the plyr package
library(plyr)

# Calculate the mean grade for each sex
gender_mean <- ddply(
  student6,
  "Sex",
  summarise,
  GradeAverage = mean(Grade, na.rm = TRUE)
)

# Display the results
gender_mean

# Step 3: Export Average Grades to a Text File

# Write the grouped averages to a text file
write.table(
  gender_mean,
  file = "gender_mean.txt",
  sep = "\t",
  row.names = FALSE
)

# Verify that the file was created
file.exists("gender_mean.txt")

# Display the contents of the exported file
read.table(
  "gender_mean.txt",
  header = TRUE,
  sep = "\t"
)

# Check where the file was saved
getwd()


# Step 4: Filter Students by Name

# Select students whose names contain i or I
i_students <- subset(
  student6,
  grepl("i", Name, ignore.case = TRUE)
)

# Display the filtered dataset
i_students

# Count the number of matching students
nrow(i_students)

# Export the names to a CSV file
write.csv(
  i_students$Name,
  file = "i_students.csv",
  row.names = FALSE,
  quote = FALSE
)

# Verify that the CSV file was created
file.exists("i_students.csv")

# Step 5: Export the Complete Filtered Dataset

# Save all columns for students with i in their names
write.csv(
  i_students,
  file = "i_students_full.csv",
  row.names = FALSE
)

# Verify the file was created
file.exists("i_students_full.csv")

# Display the exported dataset
read.csv("i_students_full.csv")

# Confirm all three exported files exist
file.exists(c(
  "gender_mean.txt",
  "i_students.csv",
  "i_students_full.csv"
))



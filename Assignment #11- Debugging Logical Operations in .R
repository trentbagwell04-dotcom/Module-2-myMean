# Assignment #11 - Debugging in R
# File: module11_debug.R
#Blog: https://trent031204.blogspot.com/2026/11/assignment-11-debugging-logical.html
# Define Tukey outlier function
tukey.outlier <- function(x) {
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- IQR(x)
  
  return(x < (q1 - 1.5 * iqr) |
           x > (q3 + 1.5 * iqr))
}

# Create test matrix
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

cat("Test Matrix:\n")
print(test_mat)


# PART 1: Original function with bug
tukey_multiple <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  
  outlier.vec <- logical(nrow(x))
  
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}

# Reproduce original warning or error
cat("\nOriginal Function Results:\n")

tryCatch(
  withCallingHandlers(
    print(tukey_multiple(test_mat)),
    warning = function(w) {
      cat("Warning:", conditionMessage(w), "\n")
      invokeRestart("muffleWarning")
    }
  ),
  error = function(e) {
    cat("Error:", conditionMessage(e), "\n")
  }
)


# PART 2: Corrected function
corrected_tukey <- function(x) {
  
  # Defensive checks
  if (!is.matrix(x) || !is.numeric(x)) {
    stop("Input must be a numeric matrix.")
  }
  
  if (nrow(x) == 0 || ncol(x) == 0) {
    stop("Matrix must have at least one row and column.")
  }
  
  if (any(!is.finite(x))) {
    stop("Matrix cannot contain NA, NaN, or Inf values.")
  }
  
  # Identify outliers
  outliers <- array(TRUE, dim = dim(x))
  
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  
  # Check each row
  outlier.vec <- logical(nrow(x))
  
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}


# PART 3: Test corrected function
cat("\nCorrected Function Results:\n")

result <- corrected_tukey(test_mat)
print(result)


# PART 4: Validate results
cat("\nOutput Length:\n")
print(length(result))

cat("\nIs Logical Vector:\n")
print(is.logical(result))

stopifnot(length(result) == 10)
stopifnot(is.logical(result))

cat("\nAll validation tests passed!\n")


# PART 5: Test defensive programming
cat("\nTesting Invalid Inputs:\n")

tryCatch(
  corrected_tukey(matrix(letters[1:10], nrow = 5)),
  error = function(e) {
    cat("Error:", conditionMessage(e), "\n")
  }
)

tryCatch(
  corrected_tukey(matrix(c(1, 2, NA, 4), nrow = 2)),
  error = function(e) {
    cat("Error:", conditionMessage(e), "\n")
  }
)

cat("\nAssignment #11 Debugging Complete!\n")

library(testthat)

test <- data.frame("Incident_Type" = c("WSP", "WMCI", "WHF", "WWC", "WHCC", "WSP", "WMCI", "WHF", "WWC", "WHCC"),
                   "n" = seq(1, 10),
                   "n2" = as.double( seq(11, 20) ),
                   "string" = c(LETTERS[1:10]),
                   "test2" = c("A", "A", "B", "B", "C", "C", "D", "E", "F", "A"),
                   "factor" = as.factor(rep(letters[1:5], 2)),
                   "test" = c(rep(TRUE, 6), FALSE, NA, NA, NA)
                   )

test_that("make_codebook works", {
  # Check the return type
  expect_type(
    make_codebook(test, return_df = TRUE),
    "list"
    )
  # Check the data object class
  expect_s3_class(
    make_codebook(test, return_df = TRUE),
    "data.frame"
    )
  # Check that the output length matches the width of the input
  expect_equal(
    nrow(make_codebook(test, return_df = TRUE)),
    ncol(test)
  )
  # Check that required names are returned
  expect_contains(
    names(make_codebook(test, return_df = TRUE)),
    c("Variable_Name", "Data_Class", "Valid_Values", "Statistics", 
      "Unique_Values", "Missing_Values")
    )
  # Check that variables in first column match the column headers of input
  expect_equal(
    make_codebook(test, return_df = TRUE)[[1]],
    names(test)
  )
  # No NAs values in the core columns
  expect_false(
    sapply(
      c("Variable_Name", "Data_Class", "Valid_Values", "Statistics", 
        "Unique_Values", "Missing_Values"),
      \(x) is.na(make_codebook(test, return_df = TRUE)[x])
      ) |> all()
  )
})
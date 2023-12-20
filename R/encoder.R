#' @title Variable Encoder
#' 
#' @description Ever needed to work with an anonymized data set but hated having
#' to manually recode your variables? Well this function was built to address 
#' that particular challenge. In essence, it takes at least two arguments a `df`
#' or data frame and a `vars` arguments, which represents a character vector of
#' variable names. From there, the function repetitively groups and updates the 
#' values of the referenced columns (`vars`) with random numbers. Thus, masking 
#' the initial data set and ensuring anonymity. And just like that, your data is
#' anonymized!
#'
#' @details
#' While the are multiple ways to encode data, this approach uses label encoding
#' to assign each variable a unique integer value. This is a simpler method than
#' most (e.g., on hot encoding) but it has the potential drawback of creating 
#' misinterpretations of the data. Namely, by giving the impression that the 
#' encoded variables have an ordered relationship when the in fact do not.
#'  
#' 
#' @param df a data frame that will be encoded.
#' @param vars a character vector of variables with the data frame that will be
#' recoded using a randomized numeric value.
#' @param tag a boolean, when \code{TRUE} the recoded value will be prefixed 
#' with the variable name and an underscore (e.g., 'varname_123'). Defaults to 
#' \code{FALSE}.
#' 
#' @importFrom data.table setDT setDF set
#'
#' @examples
#' \dontrun{
#' test <- data.frame(id = LETTERS[1:20], vals = 1:20)
#' encode_variables(df = test, 'id')
#' }
#' 
#' @export
encode_variables <- function(df, vars, tag = FALSE) {
  stopifnot("`df` must be a data.frame" = inherits(df, "data.frame"))
  stopifnot("`vars` must be in df" = all(vars %in% names(df)))
  stopifnot("`tag` must be a boolean" = inherits(tag, "logical"))
  
  data.table::setDT(df)
  
  mapply(function(x) {
    init <- class(df[[x]])
    unique_val <- sample(
      1:length(unique(get(x, df))),
      length(unique(get(x, df))), 
      replace = FALSE) |>
      `names<-`(unique(get(x, df)))
    if (tag) {
      # Everything is returned as a character
      set(df, j = x, value = paste(x, unique_val[ as.character(get(x, df)) ], 
                                   sep = "_"))
    } else {
      set(df, j = x, value = unique_val[ as.character(get(x, df)) ])
      # The initial variable class is respected
      set(df, j = x, value = `class<-`(get(x, df), init))
    }
  },
  vars)
  
  setDF(df)
  
  return(df)
}
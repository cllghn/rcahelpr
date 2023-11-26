#' @title Find Vector Mode
#' 
#' @param v is an atomic vector.
#' @param na.rm a logical indicating whether missing values should be removed.
#' 
#' @examples
#' \dontrun{
#' ex <- as.Date(c("2020-01-01", "2020-01-01", "2020-01-01", "2020-01-01", "2020-01-02", "2020-01-02", "2020-01-03", "2020-01-03"))
#' modefinder(ex)
#' }
#' 
#' @keywords internal
modefinder <- function(v, na.rm = TRUE) {
  if(na.rm) v <- v[!is.na(v)]
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

#' @keywords internal
statisticstmaker <- function(column) {
  stats <- switch(
    class(column),
    "Date" = sprintf(
      "Min: %s <br> Mode: %s <br> Max: %s <br> Time difference: %s days",
      min(column, na.rm = TRUE), modefinder(column), max(column, na.rm = TRUE),
      ( max(column, na.rm = TRUE) - min(column, na.rm = TRUE) )
    ),
    "logical" = sprintf("TRUE=%s (%s%%) <br> FALSE=%s (%s%%) <br> NA=%s (%s%%)",
                        sum(column, na.rm = TRUE),
                        (sum(column, na.rm = TRUE)/length(column)) * 100,
                        sum(!column, na.rm = TRUE),
                        (sum(!column, na.rm = TRUE)/length(column)) * 100,
                        sum(is.na(column)),
                        (sum(is.na(column))/length(column)) * 100
    ),
    "integer" = sprintf("Min: %s <br> Avg: %s <br> Median: %s <br> Max: %s <br> SD: %s",
                        round(min(column, na.rm = TRUE), 2),
                        round(mean(column, na.rm = TRUE), 2),
                        round(median(column, na.rm = TRUE), 2),
                        round(max(column, na.rm = TRUE), 2),
                        round(sd(column, na.rm = TRUE), 2)
    ),
    "numeric" = sprintf("Min: %s <br> Avg: %s <br> Median: %s <br> Max: %s <br> SD: %s",
                        round(min(column, na.rm = TRUE), 2),
                        round(mean(column, na.rm = TRUE), 2),
                        round(median(column, na.rm = TRUE), 2),
                        round(max(column, na.rm = TRUE), 2),
                        round(sd(column, na.rm = TRUE), 2)
    ),
    "character" = ifelse(
      length(unique(column)) <= 3,
      sprintf("%i Unique strings: %s", 
              length(unique(column)),
              paste(unique(column), collapse = ", ")
      ),
      sprintf("%i unique strings, top three: <br> %s (n=%s) <br> %s (n=%s) <br> %s (n=%s)",
              length(unique(column)),
              names(table(column)[order(table(column), decreasing = TRUE)][1]),
              table(column)[order(table(column), decreasing = TRUE)][1],
              names(table(column)[order(table(column), decreasing = TRUE)][2]),
              table(column)[order(table(column), decreasing = TRUE)][2],
              names(table(column)[order(table(column), decreasing = TRUE)][3]),
              table(column)[order(table(column), decreasing = TRUE)][3])
    ),
    "factor" = ifelse(
      length(unique(column)) <= 3,
      sprintf("%i Unique factors: %s", 
              length(unique(column)),
              paste(unique(column), collapse = ", ")
      ),
      sprintf("%i unique factors, top three: <br> %s (n=%s) <br> %s (n=%s) <br> %s (n=%s)",
              length(unique(column)),
              names(table(column)[order(table(column), decreasing = TRUE)][1]),
              table(column)[order(table(column), decreasing = TRUE)][1],
              names(table(column)[order(table(column), decreasing = TRUE)][2]),
              table(column)[order(table(column), decreasing = TRUE)][2],
              names(table(column)[order(table(column), decreasing = TRUE)][3]),
              table(column)[order(table(column), decreasing = TRUE)][3])
    )
  )
  stats
}

#' @keywords internal
valuemaker <- function(column) {
  valid <- switch(
    class(column),
    "Date" = sprintf(
      "Date rage from %s to %s.",
      min(column, na.rm = TRUE), max(column, na.rm = TRUE)
    ),
    "logical" = sprintf(
      "Logical TRUE (n=%s) and FALSE (n=%s) values.",
      sum(column, na.rm = TRUE), sum(!column, na.rm = TRUE)
    ),
    "numeric" = sprintf(
      "Numeric range from %s to %s.",
      min(column, na.rm = TRUE), max(column, na.rm = TRUE)
    ),
    "integer" = sprintf(
      "Numeric range from %s to %s.",
      min(column, na.rm = TRUE), max(column, na.rm = TRUE)
    ),
    "character" = ifelse(
      length(unique(column)) <= 3,
      sprintf("Unique strings: %s.", 
              paste(unique(column), collapse = ", ")),
      sprintf("Unique strings (n=%i): %s, %s, %s, and more.",
              length(unique(column)), unique(column)[1],
              unique(column)[2], unique(column)[3])
    ),
    "factor" = ifelse(
      length(unique(column)) <= 3,
      sprintf("Categorical variable with %s levels: %s",
              length(unique(levels(column))),
              paste(unique(column), collapse = ", ")),
      sprintf("Categorical variable with %s levels: %s, %s, %s, and more.",
              length(unique(levels(column))),
              unique(levels(column))[1], 
              unique(levels(column))[2],
              unique(levels(column))[3])
    )
  )
  valid 
}

#' @title Codebook Maker
#' 
#' @param input_df A \code{data.frame} that will be summarized as a codebook.
#' @param return_df A boolean set by default to \code{TRUE}, if \code{FALSE}
#' it will return the table as HTML or LaTeX.
#' @param format A string set to \code{NULL} by default. If \code{NULL} and 
#' the \code{return_df} parameter is set to \code{FALSE}, this argument may be 
#' set to \code{"html"} or \code{"latex"} to determine the output of the table.
#' @param escape A boolean; whether to escape special characters when producing 
#' HTML or LaTeX tables. When \code{escape = FALSE}, you have to make sure that 
#' special characters will not trigger syntax errors in LaTeX or HTML.
#' @param extra_vars A \code{data.frame} of variables that wil be left joined.
#' @param extra_key A character; specifying the column used for merging the \code{extra_vars} table.
#' @param ... Other arguments (see Examples and References).
#' 
#' 
#' @importFrom kableExtra kable kable_styling
#' @importFrom tools toTitleCase
#' @importFrom stats median sd
#' 
#' @examples
#' \dontrun{
#' # Create a test data.frame
#' test <- data.frame("Incident_Type" = c("WSP", "WMCI", "WHF", "WWC", "WHCC", 
#'                                         "WSP", "WMCI", "WHF", "WWC", "WHCC"),
#'  "n" = seq(1, 10),
#'  "n2" = as.double( seq(11, 20) ),
#'  "string" = c(LETTERS[1:10]),
#'  "test2" = c("A", "A", "B", "B", "C", "C", "D", "E", "F", "A"),
#'  "factor" = as.factor(rep(letters[1:5], 2)),
#'  "test" = c(rep(TRUE, 6), FALSE, NA, NA, NA)
#'  )
#' 
#' # Return HTML table.
#' codemaker(test, return_df =  FALSE, format = "html", 
#' latex_options = "striped", escape = FALSE, extra_vars = added_vars, 
#' extra_key = "var_name")
#' 
#' }
#' 
#' 
#' @export
make_codebook <- function(input_df, return_df = TRUE, format = NULL, 
                          escape = TRUE, extra_vars = NULL, 
                          extra_key = NULL, ...) {
  # Check inputs ===============================================================
  stopifnot( "`input_df` must be a data.frame" = is.data.frame(input_df) )
  stopifnot( "`return_df` must be a logical" = is.logical(return_df) )
  stopifnot("`escape` must be a logical" = is.logical(escape))
  if (is.null(format)) format <- "html" else stopifnot("`format` must be valid string" = is.character(format) && format %in% c("html", "latex") )
  if (!is.null(extra_vars)) {
    stopifnot("`extra_vars` must be a `data.frame`" = is.data.frame(extra_vars))
    stopifnot("`extra_key` must be a column name on `extra_vars`" = extra_key %in% names(extra_vars) && is.character(extra_key))
  }
  
  # Create codebook data.frame ================================================= 
  out <- data.frame(
    "Variable Name" = names(input_df),
    "Data Class" = tools::toTitleCase(
      sapply(names(input_df), \(x) class(input_df[[x]]))
    ),
    "Valid Values" = sapply(
      names(input_df), \(x) valuemaker(input_df[[x]])
    ),
    "Statistics" = sapply(
      names(input_df), \(x) statisticstmaker(input_df[[x]])
    ),
    "Unique Values" = sapply(
      names(input_df), \(x) length(unique(input_df[[x]]))
    ),
    "Missing Values" = sapply(
      names(input_df), \(x) sprintf(
        "%s (%s%%)",
        sum(is.na(input_df[[x]])), 
        round(sum(is.na(input_df[[x]])) / length(input_df[[x]]), 2) * 100)
    )
  )
  
  # Left join ==================================================================
  if (!is.null(extra_vars)) out <- merge(out, extra_vars,
                                         by.x = names(out)[[1]],
                                         by.y = extra_key,
                                         all.x = TRUE)
  
  # Cosmetic details ===========================================================
  row.names(out) <- NULL
  if (return_df) out <- `colnames<-`(
    as.data.frame(
      lapply(
        names(out),
        \(x) if (is.character(out[[x]])) gsub("<br>", "|", out[[x]]) else out[[x]]
      )
    ),
    names(out)
  ) 
  if (format == "latex") out <- `colnames<-`(
    as.data.frame(
      lapply(
        names(out),
        \(x) if (is.character(out[[x]])) gsub("<br>", "\\linebreak", out[[x]]) else out[[x]]
      ) 
    ),
    names(out)
  )
  names(out) <- gsub("\\.", "\\_", names(out))
  
  # Returns ====================================================================
  if (return_df) {
    out
  } else {
    kableExtra::kable(out, row.names = FALSE, format = format, escape = escape,
                      col.names = tools::toTitleCase(
                        gsub("\\_|\\.", " ", names(out)))
    ) |> 
      kableExtra::kable_styling(...) 
  }
}
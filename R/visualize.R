#' @title Visualize Single Variable
#' 
#' @description
#' An opinionated function that delivers single varible descriptive graphs based
#' on the variable's class.
#' 
#' @param df A data frame from which a variable will be visualized.
#' @param var A character representing the name of a single variable of a given
#' data frame.
#' @param xlab An required character representing the label that will be places 
#' on the x-axis.
#' @param ylab An optional character representing the label that will be places 
#' on the y-axis.
#' @param theme A ggplot theme used to tweak the display of the graph.
#' @param widget A boolean which defaults to `FALSE`. When `TRUE`, the graph is
#' returned as an interactive HTML widget powered by the {plotly} library.
#' @param flip A boolean which defaults to `FALSE`. When `TRUE`, the graph is
#' turned on its axis.
#' @param ... Other arguments passed on to the geom functions.
#' 
#' @importFrom ggplot2 ggplot aes coord_flip geom_bar geom_histogram xlab ylab geom_freqpoly
#' @importFrom plotly ggplotly
#' @importFrom forcats fct_infreq fct_rev
#' 
#' @examples
#' \dontrun{
#' d <- data.frame(
#'   "char" = rep(LETTERS[1:5], 10),
#'   "ints" = rep(c(1L, 2L), 25)
#'  )
#'  
#' visualize_sngl_var(d, "ints", widget = TRUE, xlab = "Integers",
#'    ylab ="Count")
#' }
#' 
#' 
#' @export
visualize_sngl_var <- function(df, var, xlab, ylab = NULL, theme = NULL, 
                               widget = FALSE, flip = FALSE, ...) {
  stopifnot("`df` must be a data.frame" = inherits(df, "data.frame"))
  stopifnot("`var` must be in df" = all(var %in% names(df)))
  stopifnot("`xlab` must be a character" = inherits(xlab, "character"))
  if (!is.null(ylab)) {
    stopifnot("`xlab` and/or `ylab` must be strings." = is.character(ylab))
  }
  if (!is.null(theme)) stopifnot("`theme` must be ggplot theme." = inherits(theme, "theme"))
  stopifnot("`widget` must be a boolean." = inherits(widget, "logical"))
  stopifnot("`flip` must be a boolean." = inherits(flip, "logical"))
  
  init <- ggplot(data = df)
  
  graph <- switch(
    class(df[[var]]),
    "Date" = init + geom_freqpoly(aes(x = get(var)), ...),
    "logical" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var)))), ...),
    "numeric" = init + geom_histogram(aes(x = get(var)), ...),
    "integer" = init + geom_histogram(aes(x = get(var)), ...),
    "character" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var)))), ...),
    "factor" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var)))), ...)
  )
  
  graph <- graph + xlab(xlab)
  
  if (!is.null(ylab)) graph <- graph + ggplot2::ylab(ylab)
  if (!is.null(theme)) graph <- graph + theme
  if (flip) graph <- graph + coord_flip()
  
  if (widget) {
    plotly::ggplotly(graph)
  } else {
    graph
  }
}


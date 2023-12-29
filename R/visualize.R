#' @title Visualize Single Variable
#' 
#' @description
#' An opinionated function that delivers single varible descriptive graphs based
#' on the variable's class.
#' 
#' @param df A data frame from which a variable will be visualized.
#' @param var A character representing the name of a single variable of a given
#' data frame.
#' @param xlab An required character value representing the label that will be 
#' placed on the x-axis. You may be asking, why do I need to provide this when 
#' the variable named is also required. Simply, so that the user can explicitly
#' decide how the variable label will be printed for users.
#' @param ylab An optional character representing the label that will be placed 
#' on the y-axis.
#' @param theme A ggplot theme used to tweak the display of the graph.
#' @param widget A boolean which defaults to `FALSE`. When `TRUE`, the graph is
#' returned as an interactive HTML widget powered by the {plotly} library.
#' @param flip A boolean which defaults to `FALSE`. When `TRUE`, the graph is
#' turned on its axis.
#' @param cutoff A numeric value used to select the number of variables that 
#' will be graphed when working with categorical data. This value is intended to
#' limit the amount of bars plotted and make graphs more legible. Defaults to a
#' value of 30. 
#' @param ... Other arguments passed on to the geom, labs, ggplotly, or plotly 
#' config functions.
#' 
#' @importFrom ggplot2 ggplot aes coord_flip geom_bar geom_histogram xlab ylab 
#' geom_freqpoly labs
#' @importFrom plotly ggplotly config
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
                               widget = FALSE, flip = FALSE, cutoff = 30, ...) {
  stopifnot("`df` must be a data.frame" = inherits(df, "data.frame"))
  stopifnot("`var` must be in df" = all(var %in% names(df)))
  stopifnot("`xlab` must be a character" = inherits(xlab, "character"))
  if (!is.null(ylab)) {
    stopifnot("`xlab` and/or `ylab` must be strings." = is.character(ylab))
  }
  if (!is.null(theme)) stopifnot("`theme` must be ggplot theme." = inherits(theme, "theme"))
  stopifnot("`widget` must be a boolean." = inherits(widget, "logical"))
  stopifnot("`flip` must be a boolean." = inherits(flip, "logical"))
  stopifnot("`cutoff` must be a number." = is.numeric(cutoff))
  
  cutoff_caption <- FALSE
  
  # Return "head" for character and factors to limit how much is graphed
  if (inherits(df[[var]], "factor") | inherits(df[[var]], "character") && 
      length(unique(df[[var]])) > cutoff) {
    init_values <- length(unique(df[[var]])) 
    to_keep <- names( sort(table(df[[var]]), decreasing = TRUE)[1:cutoff] )
    df <- df[df[[var]] %in% to_keep, ]
    cutoff_caption <- TRUE
  }
  
  init <- ggplot(data = df) + xlab(xlab)
  
  graph <- switch(
    class(df[[var]]),
    "Date" = init + geom_freqpoly(aes(x = get(var),
                                      text = paste0(var, ": ", get(var))), ...),
    "logical" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var))), 
                                    text = paste0(var, ": ", fct_rev(fct_infreq(get(var))))), ...),
    "numeric" = init + geom_histogram(aes(x = get(var),
                                          text = paste0(var, ": ", get(var))), ...),
    "integer" = init + geom_histogram(aes(x = get(var),
                                          text = paste0(var, ": ", get(var))), ...),
    "character" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var))),
                                      text = paste0(var, ": ", fct_rev(fct_infreq(get(var))))), ...),
    "factor" = init + geom_bar(aes(x = fct_rev(fct_infreq(get(var))),
                                   text = paste0(var, ": ", fct_rev(fct_infreq(get(var))))), ...)
  )
  
  if (!is.null(ylab)) graph <- graph + ylab(ylab)
  if (!is.null(theme)) graph <- graph + theme
  if (flip) graph <- graph + coord_flip()
  if (cutoff_caption) graph <- switch(
    class(df[[var]]),
    "character"= graph + labs(caption = sprintf("Only displaying the top %i most common character values, %i values not shown.", cutoff, init_values - cutoff), ...),
    "factor" = graph + labs(caption = sprintf("Only displaying the top %i most common factor values, %i values not shown.", cutoff, init_values - cutoff), ...)
  )
  
  if (widget) { plotly::ggplotly(graph, tooltip = c("text", "count"), ...) |> 
      config(displaylogo = FALSE, ...) 
    } else { graph }
}


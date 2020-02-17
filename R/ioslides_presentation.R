#' ioslides_presentation
#'
#' Format for converting from R Markdown to an [ioslides](https://code.google.com/p/io-2012-slides/) presentation.
#'
#' @inheritParams rmarkdown::ioslides_presentation
#' @param ... Arguments to be passed to a specific output format function `rmarkdown::ioslides_presentation`
#'
#' @return R Markdown output format to pass to render
#' @export
ioslides_presentation <- function(
  smaller = FALSE,
  mathjax = "default",
  self_contained = TRUE,
  fig_width = 5.94,
  fig_height = 3.30,
  transition = 0.5,
  incremental = FALSE,
  ...
) {
  csl <- system.file("rmarkdown/templates/ioslides/resources/csl/apa.csl", package = "umr1283")
  rmarkdown::ioslides_presentation(
    css = system.file("rmarkdown/templates/ioslides/resources/mc_theme.css", package = "umr1283"),
    logo = system.file("rmarkdown/templates/ioslides/resources/logo_UMR.png", package = "umr1283"),
    pandoc_args = paste0("--csl=", csl),
    ...
  )
}

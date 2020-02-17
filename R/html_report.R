#' html_report
#'
#' These are simple wrappers of the output format functions like rmarkdown::html_document(),
#' and they added the capability of numbering figures/tables/equations/theorems
#' and cross-referencing them. See References for the syntax. Note you can also cross-reference
#' sections by their ID's using the same syntax when sections are numbered.
#' In case you want to enable cross reference in other formats, use markdown_document2
#' with base_format argument.
#'
#' @inheritParams rmarkdown::html_document
#' @inheritParams bookdown::html_document2
#' @param ... Arguments to be passed to a specific output format function `rmarkdown::html_document`
#'
#' @return R Markdown output format to pass to render
#' @export
html_report <- function(
  theme = "simplex",
  toc = TRUE,
  toc_depth = 3,
  fig_width = 6.3,
  fig_height = 4.7,
  number_sections = TRUE,
  self_contained = TRUE,
  mathjax = "default",
  df_print = "kable",
  code_download = TRUE,
  ...
) {
  bookdown::html_document2(...)
}

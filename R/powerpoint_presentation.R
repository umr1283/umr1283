#' powerpoint_presentation
#'
#' Format for converting from R Markdown to a PowerPoint presentation. Pandoc v2.0.5 or above is required.
#'
#' @inheritParams rmarkdown::powerpoint_presentation
#' @param ... Arguments to be passed to a specific output format function `rmarkdown::powerpoint_presentation`
#'
#' @return R Markdown output format to pass to render
#' @export
powerpoint_presentation <- function(fig_width = 5.94, fig_height =  3.30, ...) {
  template <- system.file("rmarkdown/templates/powerpoint/resources/template.pptx", package = "umr1283")
  rmarkdown::powerpoint_presentation(reference_doc = template, ...)
}

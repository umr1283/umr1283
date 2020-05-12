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
  csl_default <- system.file("rmarkdown/templates/ioslides/resources/csl/apa.csl", package = "umr1283")
  css_default <- system.file("rmarkdown/templates/ioslides/resources/mc_theme.css", package = "umr1283")
  logo_default <- system.file("rmarkdown/templates/ioslides/resources/logo_UMR.png", package = "umr1283")

  params_ellipsis <- list(...)
  if (length(params_ellipsis) != 0) {
    if (grepl("pandoc_args", names(params_ellipsis))) {
      pandoc_args <- paste(
        params_ellipsis[["pandoc_args"]],
        paste0("--csl=", if (grepl("csl", names(params_ellipsis))) params_ellipsis[["csl"]] else csl_default)
      )
    } else {
      pandoc_args <- paste0(
        "--csl=", if (grepl("csl", names(params_ellipsis))) params_ellipsis[["csl"]] else csl_default
      )
    }
    css <- if (grepl("css", names(params_ellipsis))) params_ellipsis[["css"]] else css_default
    logo <- if (grepl("logo", names(params_ellipsis))) params_ellipsis[["logo"]] else logo_default
  } else {
    css <- css_default
    logo <- logo_default
    pandoc_args <- paste0("--csl=", csl_default)
  }
  rmarkdown::ioslides_presentation(css = css, logo = logo, pandoc_args = pandoc_args, ...)
}

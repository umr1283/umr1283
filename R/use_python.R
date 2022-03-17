#' Use Python
#'
#' Setup directory structure for `python`.
#'
#' @param project A character string. The path to a (RStudio) project.
#' @param type Type of Python environment to use, see `renv::use_python` for details.
#'
#' @export
use_python <- function(project = ".", type = "virtualenv") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    if (nchar(system.file(package = "renv")) == 0) {
      stop("\"renv\" is not installed!\ninstall.packages(\"renv\") to install it.")
    }

    renv::use_python(type = type)
  })

  invisible(TRUE)
}

#' use_targets
#'
#' Setup directory structure for `targets`.
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory Path to the working temporary directory.
#' @param ... Not used.
#'
#' @export
use_targets <- function(project = ".", working_directory = "/disks/DATATMP", ...) {
  if (nchar(system.file(package = "targets")) == 0) {
    warning('"targets" is not installed!\nrenv::install(c("targets", "visNetwork")) to install it.')
  }

  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    dir.create(
      path = file.path(working_directory, basename(proj), "_targets"),
      recursive = TRUE, showWarnings = FALSE, mode = "0775"
    )
    file.symlink(
      from = file.path(working_directory, basename(proj), "_targets"),
      to = file.path(proj, "_targets")
    )
    cat("_targets\n", file = file.path(proj, ".gitignore"), append = TRUE)
    cat("library(targets)\n", file = file.path(proj, "_targets.R"))
  })

  invisible(TRUE)
}

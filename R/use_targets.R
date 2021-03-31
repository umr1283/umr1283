#' use_targets
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory Path to the working temporary directory.
#' @param ... Any parameter to `targets::tar_script`.
#'
#' @export
use_targets <- function(project = rprojroot::find_rstudio_root_file(), working_directory = "/disks/DATATMP", ...) {
  if (nchar(system.file(package = "targets")) == 0) {
    stop('"targets" is not installed!\nrenv::install(c("targets", "visnetwork")) to install it.')
  }
  dir.create(
    path = file.path(working_directory, basename(project), "_targets"),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  file.symlink(
    from = file.path(working_directory, basename(project), "_targets"),
    to = file.path(project, "_targets")
  )
  cat("_targets\n", file = file.path(project, ".gitignore"), append = TRUE)
  cat("library(targets)\n", file = file.path(project, "_targets.R"))
  invisible()
}

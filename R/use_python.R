#' use_python
#'
#' Setup directory structure for `python`.
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory Path to the working temporary directory.
#' @param type Type of Python environment to use.
#' @param ... Not used.
#'
#' @export
use_python <- function(project = rprojroot::find_rstudio_root_file(), working_directory = "/disks/DATATMP", type = "virtualenv", ...) {
  if (nchar(system.file(package = "renv")) == 0) {
    stop('"renv" is not installed!\ninstall.packages("renv") to install it.')
  }
  dir.create(
    path = file.path(working_directory, basename(project), "python"),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  file.symlink(
    from = file.path(working_directory, basename(project), "python"),
    to = file.path(project, "renv", "python")
  )
  renv::use_python(type = type, project = project)
  system(paste(file.path(project, "renv/python/virtualenvs/renv-python-3.7.3/bin/python"), "-m ensurepip"))
  invisible(project)
}

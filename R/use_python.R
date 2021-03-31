#' use_python
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory Path to the working temporary directory.
#' @param type Type of Python environment to use.
#'
#' @export
use_python <- function(project = rprojroot::find_rstudio_root_file(), working_directory = "/disks/DATATMP", type = "virtualenv") {
  if (nchar(system.file(package = "renv")) == 0) {
    stop('"renv" is not installed!\ninstall.packages("renv") to install it.')
  }
  dir.create(
    path = file.path(working_directory, basename(path), "python"),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  file.symlink(
    from = file.path(working_directory, basename(path), "python"),
    to = file.path(path, "renv", "python")
  )
  renv::use_python(type = type)
  system(paste(file.path(path, "renv/python/virtualenvs/renv-python-3.7.3/bin/python"), "-m ensurepip"))
  invisible()
}

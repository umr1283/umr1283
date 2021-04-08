#' @keywords internal
use_group_permission <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  Sys.chmod(paths = proj, mode = "0775", use_umask = FALSE)

  withr::with_dir(proj, {
    Sys.chmod(
      paths = list.files(
        path = ".",
        recursive = TRUE, all.files = TRUE, include.dirs = TRUE,
        full.names = TRUE
      ),
      mode = "0775",
      use_umask = FALSE
    )
  })

  invisible(TRUE)
}

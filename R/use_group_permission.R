#' @keywords internal
use_group_permission <- function(project) {
  Sys.chmod(paths = project, mode = "0775", use_umask = FALSE)

  Sys.chmod(
    paths = list.files(
      path = project,
      recursive = TRUE, all.files = TRUE, include.dirs = TRUE,
      full.names = TRUE
    ),
    mode = "0775",
    use_umask = FALSE
  )

  invisible()
}

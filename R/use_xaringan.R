#' Use Xaringan Template
#'
#' Setup directory structure for `targets`.
#'
#' @param project A character string. The path to a RStudio project.
#' @param sub_directory A character string. The path  to a directory in a RStudio project.
#' @param url remote url. Typically starts with `https://github.com/` for public repositories,
#'   and `https://yourname@github.com/` or `git@github.com/` for private repos.
#'   You will be prompted for a password or pat when needed.
#'
#' @export
use_xaringan <- function(
  project = ".",
  sub_directory = "scripts",
  url = "https://github.com/umr1283/xaringan-template",
  overwrite
) {
  proj <- normalizePath(file.path(project, sub_directory), mustWork = FALSE)

  dir.create(file.path(proj, "slides"), showWarnings = FALSE, mode = "0775")

  temp_git_dir <- file.path(tempdir(), "slides")
  on.exit(unlink(temp_git_dir, recursive = TRUE, force = TRUE))
  gert::git_clone(url = url, path = temp_git_dir)
  stopifnot(all(file.copy(
    from = list.files(
      path = temp_git_dir,
      pattern = "assets|.Rmd$",
      full.names = TRUE
    ),
    to = file.path(proj, "slides"),
    recursive = TRUE,
    overwrite = overwrite
  )))
}
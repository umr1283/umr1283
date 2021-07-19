#' Use Xaringan Template
#'
#' Setup directory structure for `targets`.
#'
#' @param path A character string. The path to a directory within a RStudio project.
#' @param url A character string. A remote url, that ypically starts with `https://github.com/` for public repositories,
#'   and `https://yourname@github.com/` or `git@github.com/` for private repos.
#'   You will be prompted for a password or pat when needed.
#' @param overwrite A logical. Should existing destination files be overwritten?
#'
#' @export
use_xaringan <- function(
  path = "./scripts/slides",
  url = "https://github.com/umr1283/xaringan-template",
  overwrite = TRUE
) {
  proj <- normalizePath(path, mustWork = FALSE)

  dir.create(proj, showWarnings = FALSE, mode = "0775")

  temp_git_dir <- file.path(tempdir(), "slides")
  on.exit(unlink(temp_git_dir, recursive = TRUE, force = TRUE))
  gert::git_clone(url = url, path = temp_git_dir)
  stopifnot(all(file.copy(
    from = list.files(
      path = temp_git_dir,
      pattern = "assets|.Rmd$",
      full.names = TRUE
    ),
    to = proj,
    recursive = TRUE,
    overwrite = overwrite
  )))
}

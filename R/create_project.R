#' Create a project specific to UMR1283 storage architecture
#'
#' @param path A character string. A path to where the project is to be created.
#' @param analyst_name A character string. The name of the analyst in charge of that project.
#' @param git_repository A character string. URL to the git server/repository.
#' @param mran A boolean. If `TRUE`, uses `paste0("https://mran.microsoft.com/snapshot/", Sys.Date())` as the CRAN repository.
#'     Default is `FALSE`.
#' @param targets A boolean. If `TRUE`, uses `use_targets()` to create directory tree for use with `targets`.
#'     Default is `TRUE`.
#' @param python A boolean. If `TRUE`, uses `use_python()` to create `renv` directory tree for use with python.
#'     Default is `FALSE`.
#' @param xaringan A boolean. If `TRUE`, uses `use_xaringan()` to create directory tree for use with `xaringan` template (*i.e.*, "https://github.com/umr1283/xaringan-template").
#'     Default is `FALSE`.
#' @param working_directory A character string. If specified, a symbolic link to the working directory will be created in the project directory under `outputs`, otherwise (default), `outputs` is a directory.
#' @param ... not used
#'
#' @return NULL
#' @export
#' @examples
#'
#' if (interactive()) {
#'   create_project(
#'     path = "_test_project",
#'     analyst_name = "Analyst Name",
#'     git_repository = "http://gitlab.local/BioStats",
#'     mran = FALSE,
#'     targets = TRUE,
#'     python = FALSE,
#'     xaringan = FALSE,
#'     working_directory = NULL
#'   )
#' }
create_project <- function(
  path,
  analyst_name,
  git_repository,
  mran = FALSE,
  targets = TRUE,
  python = FALSE,
  xaringan = FALSE,
  working_directory = NULL,
  ...
) {
  if (path == basename(path)) {
    project <- normalizePath(file.path(".", path), mustWork = FALSE)
  } else {
    project <- normalizePath(path, mustWork = FALSE)
  }

  if (!dir.exists(dirname(project))) stop(sprintf('"%s" does not exist!', dirname(project)))

  if (mran) {
    current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", Sys.Date()))
  } else {
    current_repos <- list(CRAN = "https://cloud.r-project.org/")
  }

  if (!dir.exists(project)) {
    dir.create(
      path = project,
      recursive = TRUE, showWarnings = FALSE, mode = "0775"
    )
  }

  withr::with_dir(new = project, code = {
    invisible(sapply(
      X = c("data", "docs", "reports", "scripts", "logs", "renv"),
      FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
    ))

    if (xaringan) {
      dir.create(
        path = "slides",
        recursive = TRUE, showWarnings = FALSE, mode = "0775"
      )
      use_xaringan(
        path = "slides",
        url = "https://github.com/umr1283/xaringan-template",
        overwrite = TRUE
      )
    }

    if (missing(working_directory)) {
      dir.create(
        path = "outputs",
        recursive = TRUE, showWarnings = FALSE, mode = "0775"
      )
      working_directory <- "outputs"
    } else {
      normalizePath(path = working_directory, mustWork = TRUE)
      dir.create(
        path = file.path(working_directory, basename(project), "outputs"),
        recursive = TRUE, showWarnings = FALSE, mode = "0775"
      )
      if (!dir.exists("outputs")) {
        invisible(file.symlink(
          from = file.path(working_directory, basename(project), "outputs"),
          to = "outputs"
        ))
      }
    }

    use_rproj()

    use_readme(analyst_name)

    use_gitignore()

    use_dependencies()

    use_dir_structure(
      working_directory = working_directory,
      repos = current_repos,
      targets = targets,
      python = python
    )

    use_group_permission()

    use_git(git_repository = git_repository)
  })

  message("Project created.\n")

  invisible(TRUE)
}

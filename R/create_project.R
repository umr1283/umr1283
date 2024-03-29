#' Create a project specific to UMR1283 storage architecture
#'
#' @param path A character string. A path to where the project is to be created.
#' @param analyst_name A character string. The name of the analyst in charge of that project.
#' @param git_repository A character string. URL to the git server/repository.
#' @param mran A boolean. If `TRUE`, uses `paste0("https://mran.microsoft.com/snapshot/", Sys.Date())` as the CRAN repository.
#'     Default is `FALSE`.
#' @param targets A boolean. If `TRUE`, uses `use_targets()` to create directory tree for use with `targets`.
#'     Default is `TRUE`.
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
#'     git_repository = "http://<hostname>/<namespace>"
#'   )
#' }
create_project <- function(
  path,
  analyst_name,
  git_repository = NULL,
  mran = FALSE,
  targets = TRUE,
  xaringan = FALSE,
  working_directory = NULL,
  ...
) {
  cp_call <- match.call()
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

    if (is.null(working_directory) || working_directory == "") {
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

    use_readme(analyst_name = analyst_name, project_call = cp_call)

    use_gitignore()

    use_dependencies()

    use_dir_structure(
      repos = current_repos,
      targets = targets
    )

    use_devcontainer()

    use_group_permission()

    if (!is.null(git_repository)) use_git(git_repository = git_repository)
  })

  message("Project created.\n")

  invisible(TRUE)
}

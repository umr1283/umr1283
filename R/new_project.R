#' new_project
#'
#' @param path A character string. A path to where the project is to be created.
#' @param analyst_name A character string. The name of the analyst in charge of that project.
#' @param working_directory A character string. A path to where outputs is to be generated.
#' @param git_repository A character string. URL to the git server/repository.
#' @param mran A boolean. If `TRUE`, uses `paste0("https://mran.microsoft.com/snapshot/", Sys.Date())` as the CRAN repository.
#'     Default is `FALSE`.
#' @param targets A boolean. If `TRUE`, uses `use_targets()` to create directory tree for use with `targets`.
#'     Default is `TRUE`.
#' @param python A boolean. If `TRUE`, uses `use_python()` to create `renv` directory tree for use with python.
#'     Default is `FALSE`.
#' @param ... not used
#'
#' @return NULL
#' @export
#' @examples
#'
#' if (!interactive()) {
#'   new_project(
#'     path = "/disks/PROJECT/_test_project",
#'     analyst_name = "Analyst Name",
#'     working_directory = "/disks/DATATMP",
#'     git_repository = "http://gitlab.egid.local/BioStats",
#'     mran = FALSE,
#'     targets = TRUE,
#'     python = TRUE
#'   )
#' }
#'
new_project <- function(
  path,
  analyst_name,
  working_directory,
  git_repository,
  mran = FALSE,
  targets = TRUE,
  python = FALSE,
  ...
) {
  old_repos <- getOption("repos")
  on.exit(options(repos = old_repos))

  project <- gsub("~", "", path)

  if (!dir.exists(dirname(project))) stop(sprintf('"%s" does not exist!', dirname(project)))

  dir.create(
    path = project,
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  invisible(sapply(
    X = file.path(project, c("docs", "reports", "scripts", "logs", "renv")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  ))

  invisible(sapply(
    X = file.path(working_directory, basename(project), c("outputs", "library")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  ))

  invisible(file.symlink(
    from = file.path(working_directory, basename(project), "outputs"),
    to = file.path(project, "outputs")
  ))

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(project)

  use_readme(project, analyst_name)

  use_rproj(project)

  use_gitignore(project)

  use_dependencies(project)

  if (mran) {
    current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", Sys.Date()))
  } else {
    current_repos <- list(CRAN = "https://cloud.r-project.org/")
  }

  use_dir_structure(
    project = project,
    working_directory = working_directory,
    repos = current_repos,
    targets = targets,
    python = python
  )

  use_git(project, git_repository)

  use_group_permission(project)

  invisible(project)
}

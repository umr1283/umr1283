#' migrate_project
#'
#' @param project A character string. The path a RStudio project.
#' @param date A character string. The date of the MRAN to use, *e.g.*, 2021-01-25.
#' @param working_directory A character string. The root path to the working directory of the project.
#' @param targets A boolean. If `TRUE`, uses `use_targets()` to create directory tree for use with `targets`.
#'     Default is `FALSE`.
#' @param python A boolean. If `TRUE`, uses `use_python()` to create `renv` directory tree for use with python.
#'     Default is `FALSE`.
#'
#' @return NULL
#' @export
migrate_project <- function(project = rprojroot::find_rstudio_root_file(), date, working_directory = "/disks/DATATMP", targets = FALSE, python = FALSE) {
  old_repos <- getOption("repos")
  on.exit(options(repos = old_repos))

  if (!all(c("outputs", "scripts") %in% list.files(project))) {
    stop('Project structure does not have "outputs" and "scripts" directories!', call. = FALSE)
  }

  if (missing(date)) {
    stop(paste0('"date" must be filled to define MRAN snapshot to use, e.g., ', Sys.Date(), '!'), call. = FALSE)
  }

  if (file.exists(file.path(project, "renv.lock")) & file.exists(file.path(project, "renv"))) {
    stop("`renv` setup already exists!", call. = FALSE)
  }

  project_name <- basename(project)

  dir.create(
    path = file.path(project, project_name, "renv"),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )

  old_outputs <- list.files(file.path(working_directory, project_name), full.names = TRUE)
  invisible(sapply(
    X = file.path(working_directory, project_name, c("outputs", "library")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  ))
  invisible(sapply(
    X = old_outputs,
    FUN = function(idir) {
      if (file.copy(
        from = idir,
        to = file.path(working_directory, project_name, "outputs"),
        copy.mode = TRUE,
        recursive = TRUE,
        overwrite = TRUE
      )) {
        unlink(idir, recursive = TRUE)
      }
    }
  ))
  unlink(file.path(project, "outputs"))
  file.symlink(
    from = file.path(working_directory, project_name, "outputs"),
    to = file.path(project, "outputs")
  )
  file.symlink(
    from = file.path(working_directory, project_name, "library"),
    to = file.path(project, "renv", "library")
  )

  use_dependencies(project)

  current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", date))

  use_dir_structure(project = project, working_directory = working_directory, repos = current_repos)

  use_group_permission(project)

  invisible()
}

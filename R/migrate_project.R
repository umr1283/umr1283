#' Migrate from an old version of RStudio project to renv setup
#'
#' @param project A character string. The path a RStudio project.
#' @param date A character string. The date of the MRAN to use, *e.g.*, 2021-01-25.
#' @param working_directory A character string. The root path to the working directory of the project.
#' @param targets A boolean. If `TRUE`, uses `use_targets()` to create directory tree for use with `targets`.
#'     Default is `FALSE`.
#' @param python A boolean. If `TRUE`, uses `use_python()` to create `renv` directory tree for use with python.
#'     Default is `FALSE`.
#' @param ... not used
#'
#' @return NULL
#' @export
migrate_project <- function(
  project = ".",
  date,
  working_directory = "/disks/DATATMP",
  targets = FALSE,
  python = FALSE,
  ...
) {
  proj <- normalizePath(project, mustWork = FALSE)

  proj_wd <- file.path(working_directory, basename(proj))

  if (missing(date)) {
    stop(paste0('"date" must be filled to define MRAN snapshot to use, e.g., ', Sys.Date(), "!"), call. = FALSE)
  }
  current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", date))

  withr::with_dir(new = proj, {
    if (!dir.exists("outputs") || !dir.exists("scripts")) {
      stop('Project structure does not have "outputs" and "scripts" directories!', call. = FALSE)
    }

    if (file.exists("renv.lock") && dir.exists("renv")) {
      stop("`renv` setup already exists!", call. = FALSE)
    }

    dir.create(path = "renv", recursive = TRUE, showWarnings = FALSE, mode = "0775")
    dir.create(path = file.path(proj_wd, "outputs"), recursive = TRUE, showWarnings = FALSE, mode = "0775")

    invisible(sapply(
      X = setdiff(
        list.files(proj_wd, full.names = TRUE),
        file.path(proj_wd, c("outputs", "library"))
      ),
      FUN = function(idir) {
        if (file.copy(
          from = idir,
          to = file.path(proj_wd, "outputs"),
          copy.mode = TRUE,
          recursive = TRUE,
          overwrite = TRUE
        )) {
          unlink(idir, recursive = TRUE)
        }
      }
    ))
    unlink("outputs")
    dir.create(path = file.path(proj_wd, "library"), recursive = TRUE, showWarnings = FALSE, mode = "0775")
    file.symlink(from = file.path(proj_wd, "outputs"), to = "outputs")
    file.symlink(from = file.path(proj_wd, "library"), to = "renv/library")

    use_dependencies()

    use_dir_structure(
      working_directory = working_directory,
      repos = current_repos,
      targets = targets,
      python = python
    )

    use_group_permission()
  })

  invisible(TRUE)
}

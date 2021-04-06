#' migrate_project
#'
#' @param project A character string. The path a RStudio project.
#' @param date A character string. The date of the MRAN to use, *e.g.*, 2021-01-25.
#' @param working_directory A character string. The root path to the working directory of the project.
#'
#' @return NULL
#' @export
migrate_project <- function(project = rprojroot::find_rstudio_root_file(), date, working_directory = "/disks/DATATMP") {
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
    X = file.path(working_directory, project_name, c("outputs", "library", "python")),
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
  file.symlink(
    from = file.path(working_directory, project_name, "python"),
    to = file.path(project, "renv", "python")
  )

  if (!file.exists(file.path(project, "scripts", "_dependencies.R"))) {
    writeLines(
      text = '# library("BiocManager")',
      con = file.path(project, "scripts", "_dependencies.R")
    )
  }

  current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", date))
  options(repos = current_repos)
  renv::scaffold(project = project, repos = current_repos)

  cat(
    'options("BiocManager.check_repositories" = FALSE, BiocManager.snapshots = "MRAN")\n',
    'Sys.umask("0002")\n',
    file = file.path(project, ".Rprofile"),
    append = TRUE
  )

  options("BiocManager.check_repositories" = FALSE, BiocManager.snapshots = "MRAN")

  renv::install(
    packages = c("here", "BiocManager"),
    project = file.path(project_directory, project_name),
    library = file.path(
      project_directory, project_name,
      "renv", "library",
      paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
      R.Version()[["platform"]]
    ),
    prompt = FALSE
  )

  renv::snapshot(
    project = file.path(project_directory, project_name),
    packages = c("renv", "here", "BiocManager"),
    prompt = FALSE,
    type = "all"
  )

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

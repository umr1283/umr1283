#' migrate_project
#'
#' @param path character
#' @param working_directory character
#'
#' @return NULL
#' @export
migrate_project <- function(path, date, working_directory = "/disks/DATATMP") {
  if (missing(date)) {
    stop(paste0('"date" must be filled to define MRAN snapshot to use, e.g., ', Sys.Date(), '!'), call. = FALSE)
  }

  if (file.exists(file.path(path, "renv.lock")) & file.exists(file.path(path, "renv"))) {
    stop("`renv` setup already exists!", call. = FALSE)
  }

  project_directory <- gsub("~", "", dirname(path))
  project_name <- basename(path)

    dir.create(
    path = file.path(project_directory, project_name, "renv"),
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
  unlink(file.path(project_directory, project_name, "outputs"))
  file.symlink(
    from = file.path(working_directory, project_name, "outputs"),
    to = file.path(project_directory, project_name, "outputs")
  )
  file.symlink(
    from = file.path(working_directory, project_name, "library"),
    to = file.path(project_directory, project_name, "renv", "library")
  )

  if (!file.exists(file.path(project_directory, project_name, "scripts", "00-dependencies.R"))) {
    writeLines(
      text = 'library("BiocManager")',
      con = file.path(project_directory, project_name, "scripts", "00-dependencies.R")
    )
  }

  current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", date))
  options(repos = current_repos)
  renv::scaffold(project = file.path(project_directory, project_name), repos = current_repos)

  BiocManager <- package_version(utils::available.packages(repos = getOption("repos"))["BiocManager", "Version"])

  renv::install(
    packages = if (BiocManager > "1.30.10") "BiocManager" else "Bioconductor/BiocManager",
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
    packages = c("BiocManager", "renv"),
    prompt = FALSE
  )

  Sys.chmod(
    paths = file.path(project_directory, project_name),
    mode = "0775",
    use_umask = FALSE
  )

  Sys.chmod(
    paths = list.files(
      path = file.path(project_directory, project_name),
      recursive = TRUE, all.files = TRUE, include.dirs = TRUE,
      full.names = TRUE
    ),
    mode = "0775",
    use_umask = FALSE
  )

  invisible()
}

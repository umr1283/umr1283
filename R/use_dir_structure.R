#' @keywords internal
use_dir_structure <- function(project, working_directory, repos, targets, python) {
  options(
    repos = repos,
    BiocManager.check_repositories = FALSE,
    BiocManager.snapshots = "MRAN"
  )
  use_rprofile(project)

  renv::scaffold(project = project, repos = repos)

  renv::install(
    packages = c("here", "BiocManager"),
    project = project,
    library = file.path(
      project, "renv", "library",
      paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
      R.Version()[["platform"]]
    ),
    prompt = FALSE
  )

  # Python
  if (python) {
    use_python(
      project = project,
      working_directory = working_directory,
      type = "virtualenv"
    )
  }

  # Targets
  if (targets) {
    renv::install(
      packages = c("targets", "visNetwork"),
      project = project,
      library = file.path(
        project, "renv", "library",
        paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
        R.Version()[["platform"]]
      ),
      prompt = FALSE
    )
    suppressWarnings(use_targets(
      project = project,
      working_directory = working_directory,
    ))
    cat("library(targets)\n", file = file.path(project, ".Rprofile"), append = TRUE)
  }

  renv::snapshot(project = project, prompt = FALSE, type = "all")
  invisible()
}

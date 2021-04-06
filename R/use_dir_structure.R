#' use_dir_structure
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory A character string. The root path to the working directory of the project.
#' @param repos  A character string wirh CRAN/MRAN repository.
#'
#'
#' @keywords internal
use_dir_structure <- function(project, working_directory, repos) {
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
    use_targets(
      project = project,
      working_directory = working_directory,
    )
    renv::install(
      packages = c("targets"),
      project = project,
      library = file.path(
        project, "renv", "library",
        paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
        R.Version()[["platform"]]
      ),
      prompt = FALSE
    )
    cat("library(targets)\n", file = file.path(project, ".Rprofile"), append = TRUE)
    invisible()
  }

  renv::snapshot(project = project, prompt = FALSE, type = "all")
}

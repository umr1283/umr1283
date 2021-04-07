#' @keywords internal
use_dir_structure <- function(project = rprojroot::find_rstudio_root_file(), working_directory, repos, targets, python, git_repository) {
  options(
    repos = repos,
    BiocManager.check_repositories = FALSE,
    BiocManager.snapshots = "MRAN"
  )

  project <- normalizePath(path.expand(project))

  use_rprofile(project = project)

  renv::scaffold(project = project, repos = repos)
  renv::activate(project = project)
  renv::install(packages = c("here", "BiocManager"), project = project, prompt = FALSE)

  # Targets
  if (targets) {
    renv::install(packages = c("targets", "visNetwork"), project = project, prompt = FALSE)
    suppressWarnings(use_targets(project = project, working_directory = working_directory))
    cat("library(targets)\n", file = file.path(project, ".Rprofile"), append = TRUE)
  }

  # Python
  if (python) {
    use_python(project = project, working_directory = working_directory, type = "virtualenv")
  }

  renv::snapshot(project = project, prompt = FALSE, type = "all")

  use_group_permission(project)
  use_git(project, git_repository)
  use_group_permission(project)

  invisible()
}

#' @keywords internal
use_dir_structure <- function(project = ".", working_directory, repos, targets, python) {
  proj <- normalizePath(project, mustWork = FALSE)

  callr::r(
    func = function(.project, working_directory, targets, python, git_repository, repos, use_targets, use_python, use_rprofile) {
      withr::with_dir(.project, {
        use_rprofile()

        renv::scaffold(repos = repos)
        renv::activate()
        renv::install(packages = c("here", "BiocManager"), prompt = FALSE)

        # Targets
        if (targets) {
          renv::install(packages = c("targets", "visNetwork"), prompt = FALSE)
          use_targets(working_directory = working_directory)
          cat(
            'if (interactive() & nchar(system.file(package = "targets")) > 0) library(targets)\n',
            file = ".Rprofile", append = TRUE
          )
        }

        # Python
        if (python) {
          use_python(working_directory = working_directory)
        }

        renv::snapshot(prompt = FALSE, type = "all")
      })
    },
    args = list(
      .project = proj,
      working_directory = working_directory,
      targets = targets,
      python = python,
      repos = repos,
      use_targets = use_targets,
      use_python = use_python,
      use_rprofile = use_rprofile
    ),
    repos = repos
  )

  invisible(TRUE)
}

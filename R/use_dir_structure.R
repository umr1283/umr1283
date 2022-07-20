#' @keywords internal
use_dir_structure <- function(project = ".", repos, targets) {
  proj <- normalizePath(project, mustWork = FALSE)

  callr::r(
    func = function(
      .project,
      targets,
      git_repository,
      repos,
      use_targets,
      use_rprofile
    ) {
      withr::with_dir(.project, {
        if (
          file.exists(file.path(.project, ".Rprofile")) &&
            grepl('source("renv/activate.R")', readLines(file.path(.project, ".Rprofile")))
        ) {
          message('".Rprofile" already exists! Nothing was done!')
          return(TRUE)
        }
        use_rprofile()

        renv::scaffold(repos = repos)
        renv::activate()

        # Targets
        if (targets) {
          message("Please install the following R packages within the project ...")
          message(paste(
            '  renv::install(packages = c("here", "targets",',
            '"gittargets", "tarchetypes", "visNetwork"), prompt = FALSE)'
          ))
          use_targets()
        }

        renv::snapshot(prompt = FALSE, type = "all")
      })
    },
    args = list(
      .project = proj,
      targets = targets,
      repos = repos,
      use_targets = use_targets,
      use_rprofile = use_rprofile
    ),
    repos = repos
  )

  invisible(TRUE)
}

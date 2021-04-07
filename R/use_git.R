#' @keywords internal
use_git <- function(project = rprojroot::find_rstudio_root_file(), git_repository) {
  git_remote <- gsub("https*://(.*)/(.*)", "\\1:\\2", git_repository)

  if (nchar(system.file(package = "gert")) == 0 || nchar(system.file(package = "rstudioapi")) == 0) {
    renv::install(packages = c("gert", "rstudioapi"), project = project, prompt = FALSE)
    renv::snapshot(project = project, prompt = FALSE, type = "all")
  }

  gert::git_init(path = project)
  cat("* Git initialised.\n")

  gert::git_add(files = "*", repo = project)
  if (!gert::user_is_configured(repo = project)) {
    stop('"user.name" and/or "user.email" are not set locally or globally. See ?gert::git_config().')
  }
  cat("* Files staged.\n")

  gert::git_commit_all(message = "create project", repo = project)
  cat("* Files committed.\n")

  gert::git_config_set(name = "core.sharedRepository", value = "0775", repo = project)

  gert::git_push(
    remote = sprintf("git@%s/%s.git", git_remote, basename(project)),
    set_upstream = sprintf("git@%s/%s.git", git_remote, basename(project)),
    repo = project
  )
  cat("* Commits pushed.\n")

  gert::git_remote_add(url = sprintf("git@%s/%s.git", git_remote, basename(project)), repo = project)

  invisible()
}

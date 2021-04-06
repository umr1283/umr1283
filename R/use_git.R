#' @keywords internal
use_git <- function(project, git_repository) {
  git_remote <- gsub("https*://(.*)/(.*)", "\\1:\\2", git_repository)

  gert::git_init(project)
  gert::git_add(files = "*", repo = project)
  if (!gert::user_is_configured(repo = project)) {
    stop('"user.name" and/or "user.email" are not set locally or globally. See ?gert::git_config().')
  }
  gert::git_commit_all(message = "create project", repo = project)
  gert::git_config_set(name = "core.sharedRepository", value = "0775", repo = project)
  gert::git_push(
    remote = sprintf("git@%s/%s.git", git_remote, basename(project)),
    set_upstream = sprintf("git@%s/%s.git", git_remote, basename(project))
  )
  gert::git_remote_add(url = sprintf("git@%s/%s.git", git_remote, basename(project)), repo = project)
  invisible()
}

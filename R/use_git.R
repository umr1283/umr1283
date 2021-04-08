#' @keywords internal
use_git <- function(project = ".", git_repository) {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(new = proj, {
    if (dir.exists("renv")) {
      if (nchar(system.file(package = "gert")) == 0) {
        renv::install("gert", prompt = FALSE)
        renv::snapshot(type = "all", prompt = FALSE)
      }
    }
    git_remote <- gsub("https*://(.*)/(.*)", "\\1:\\2", git_repository)

    gert::git_init()

    gert::git_add(files = "*")
    if (!gert::user_is_configured()) {
      stop('"user.name" and/or "user.email" are not set locally or globally. See ?gert::git_config().')
    }

    gert::git_commit_all(message = "create project")

    gert::git_config_set(name = "core.sharedRepository", value = "0775")

    gert::git_push(
      remote = sprintf("git@%s/%s.git", git_remote, basename(proj)),
      set_upstream = sprintf("git@%s/%s.git", git_remote, basename(proj))
    )

    gert::git_remote_add(url = sprintf("git@%s/%s.git", git_remote, basename(proj)))
  })

  invisible(TRUE)
}

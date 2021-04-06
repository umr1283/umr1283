#' @keywords internal
use_git <- function(project, git_repository) {
  git_remote <- gsub("https*://(.*)/(.*)", "\\1:\\2", git_repository)

  invisible(sapply(
    X = paste("git -C", project, c(
      "init",
      "add --all",
      "commit -am 'create project'",
      "config --local core.sharedRepository 0775",
      sprintf("push --set-upstream git@%s/%s.git master", git_remote, basename(project)),
      sprintf("push remote add origin git@%s/%s.git master", git_remote, basename(project)),
      "push origin master"
    )),
    FUN = system, ignore.stdout = TRUE, ignore.stderr = TRUE
  ))
}

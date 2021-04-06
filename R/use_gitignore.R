#' @keywords internal
use_gitignore <- function(project) {
  file <- file.path(project, ".gitignore")
  if (!file.exists(file)) {
    writeLines(
      con = file,
      text = c(
        ".Rproj.user",
        "**.Rhistory",
        "**.Rdata",
        "_targets",
        "outputs",
        "logs",
        "reports"
      )
    )
  } else {
    message(sprintf('"%s" already exists! Nothing was done!', file))
  }
}

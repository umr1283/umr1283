#' @keywords internal
use_gitignore <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- ".gitignore"
    if (!file.exists(file)) {
      writeLines(
        con = file,
        text = c(
          ".Rproj.user",
          "**.Rhistory",
          "**.Rdata",
          "_targets",
          "renv",
          "outputs",
          "logs",
          # "reports",
          "core"
        )
      )
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', file))
    }
  })
  invisible(TRUE)
}

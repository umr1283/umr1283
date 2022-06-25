#' @keywords internal
use_devcontainer <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    dir <- ".devcontainer"
    if (!dir.exists(dir)) {
      dir.create(dir, showWarnings = FALSE, mode = "0775")
      file.copy(
        from = list.files(
          path = system.file("devcontainer", package = "umr1283"),
          full.names = TRUE
        ),
        to = dir,
        overwrite = TRUE,
        copy.mode = TRUE
      )
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', dir))
    }
  })
  invisible(TRUE)
}

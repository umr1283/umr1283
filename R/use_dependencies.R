#' @keywords internal
use_dependencies <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- "scripts/_dependencies.R"
    if (!file.exists(file)) {
      file.create(file)
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', file))
    }
  })
  invisible(TRUE)
}

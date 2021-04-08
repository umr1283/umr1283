#' @keywords internal
use_readme <- function(analyst_name, project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- "README.md"
    if (!file.exists(file)) {
      writeLines(
        con = file,
        text = c(
          paste("#", basename(proj)),
          paste("Created:", Sys.time()),
          paste("Analyst:", analyst_name),
          paste("Affiliation:", use_affiliation())
        ),
        sep = "\n\n"
      )
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', file))
    }
  })
  invisible(TRUE)
}

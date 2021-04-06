#' @keywords internal
use_readme <- function(project, analyst_name) {
  file <- file.path(project, "README.md")
  if (!file.exists(file)) {
    writeLines(
      con = file,
      text = c(
        paste("#", basename(project)),
        paste("Created:", Sys.time()),
        paste("Analyst:", analyst_name),
        paste("Affiliation:", use_affiliation())
      ),
      sep = "\n\n"
    )
  } else {
    message(sprintf('"%s" already exists! Nothing was done!', file))
  }
}

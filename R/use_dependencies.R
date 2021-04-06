#' @keywords internal
use_dependencies <- function(project) {
  file <- file.path(project, "scripts", "_dependencies.R")
  if (!file.exists(file)) {
    writeLines(
      con = file,
      text = '# library("BiocManager")'
    )
  } else {
    message(sprintf('"%s" already exists! Nothing was done!', file))
  }
}

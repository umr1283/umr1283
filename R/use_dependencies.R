#' @keywords internal
use_dependencies <- function(project = rprojroot::find_rstudio_root_file()) {
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

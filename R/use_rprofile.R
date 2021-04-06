#' @keywords internal
use_rprofile <- function(project) {
  file <- file.path(project, ".Rprofile")
  if (!file.exists(file)) {
    writeLines(
      con = file,
      text = c(
        'options("BiocManager.check_repositories" = FALSE, BiocManager.snapshots = "MRAN")',
        'Sys.umask("0002")'
      )
    )
  } else {
    message(sprintf('"%s" already exists! Nothing was done!', file))
  }
}

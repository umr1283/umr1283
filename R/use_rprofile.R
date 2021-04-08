#' @keywords internal
use_rprofile <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- ".Rprofile"
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
  })
  invisible(TRUE)
}

#' @keywords internal
use_rproj <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
  file <- paste0(basename(proj), ".Rproj")
    if (!file.exists(file)) {
      writeLines(
        con = file,
        text = c(
          "Version: 1.0",
          "",
          "RestoreWorkspace: No",
          "SaveWorkspace: No",
          "AlwaysSaveHistory: No",
          "",
          "EnableCodeIndexing: Yes",
          "UseSpacesForTab: Yes",
          "NumSpacesForTab: 2",
          "Encoding: UTF-8",
          "",
          "AutoAppendNewline: Yes",
          "LineEndingConversion: Posix",
          "",
          "QuitChildProcessesOnExit: Yes"
        )
      )
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', file))
    }
  })
  invisible(TRUE)
}

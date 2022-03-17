#' @keywords internal
use_rprofile <- function(project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- ".Rprofile"
    if (!file.exists(file)) {
      writeLines(
        con = file,
        text = c(
          "Sys.umask(\"0002\")",
          "if (interactive()) options(width = 140)",
          "if (interactive() & nchar(system.file(package = \"prompt\")) > 0) prompt::set_prompt(prompt::prompt_git)"
        )
      )
    } else {
      message(sprintf("\"%s\" already exists! Nothing was done!", file))
    }
  })
  invisible(TRUE)
}

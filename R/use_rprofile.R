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
          'Sys.umask("0002")',
          'if (interactive() & nchar(system.file(package = "prompt")) > 0) prompt::set_prompt(prompt::prompt_git)',
          'if (interactive() & nchar(system.file(package = "gert")) > 0) library(gert)',
          'if (interactive() & nchar(system.file(package = "targets")) > 0) {',
          '  library(targets)',
          '  tvn <- function(targets_only = TRUE, ...) targets::tar_visnetwork(targets_only = targets_only, ...)',
          '}'
        )
      )
    } else {
      message(sprintf('"%s" already exists! Nothing was done!', file))
    }
  })
  invisible(TRUE)
}

#' Use targets package
#'
#' Setup directory structure for `targets`.
#'
#' @param project A character string. The path a RStudio project.
#' @param working_directory Path to the working temporary directory.
#' @param ... Not used.
#'
#' @export
use_targets <- function(project = ".", working_directory = "/disks/DATATMP", ...) {
  if (nchar(system.file(package = "targets")) == 0) {
    warning('"targets" is not installed!\nrenv::install(c("targets", "visNetwork")) to install it.')
  }

  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    dir.create(
      path = file.path(working_directory, basename(proj), "_targets"),
      recursive = TRUE, showWarnings = FALSE, mode = "0775"
    )
    file.symlink(
      from = file.path(working_directory, basename(proj), "_targets"),
      to = file.path(proj, "_targets")
    )
    cat("_targets\n", file = file.path(proj, ".gitignore"), append = TRUE)

    writeLines(
      text = c(
        "message(timestamp(quiet = TRUE))",
        "targets::tar_make()",
        "message(timestamp(quiet = TRUE))"
      ),
      con = file.path(proj, "scripts/00-targets.R")
    )

    writeLines(
      text = c(
        paste(c("### global libraries ", rep("=", 79)), collapse = ""),
        "library(targets)",
        "# library(tarchetypes)",
        "# library(here)",
        "# library(data.table)",
        "",
        '# tar_option_set(cue = tar_cue(mode = "never"))',
        "",
        '# targets::tar_renv(extras = "visNetwork", path = "scripts/_dependencies.R")',
        "",
        "",
        paste(c("### project setup ", rep("=", 82)), collapse = ""),
        'invisible(sapply(list.files(here("scripts"), pattern = "^tar-.*R$", full.names = TRUE), source, echo = FALSE))',
        "",
        "",
        paste(c("### targets ", rep("=", 88)), collapse = ""),
        "list(",
        '  tar_target(project, sub("(.*)_.*", "\\1", list.files(here(), pattern = ".Rproj$")), packages = "here"),',
        '  tar_target(author, "UMR1283"),',
        '  tar_target(start, "hello!")',
        ")"
      ),
      con = file.path(proj, "_targets.R")
    )
  })

  invisible(TRUE)
}

#' Use targets package
#'
#' Setup directory structure for `targets`.
#'
#' @param project A character string. The path to a project.
#' @param ... Not used.
#'
#' @export
use_targets <- function(project = ".", ...) {
  if (nchar(system.file(package = "targets")) == 0) {
    warning('"targets" is not installed!\nrenv::install(c("targets", "gittargets", "visNetwork")) to install it.')
  }

  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    dir.create(
      path = file.path(proj, "_targets"),
      recursive = TRUE, showWarnings = FALSE, mode = "0775"
    )

    writeLines(
      text = c(
        "message(timestamp(quiet = TRUE))",
        "targets::tar_make()",
        "message(timestamp(quiet = TRUE))"
      ),
      con = file.path(proj, "scripts/00-targets.R")
    )

    if (file.exists(file.path(proj, ".Rprofile"))) {
      cat(
        "if (interactive() & nchar(system.file(package = \"targets\")) > 0) {",
        "  library(targets)",
        "  tvn <- function(targets_only = TRUE, ...) targets::tar_visnetwork(targets_only = targets_only, ...)",
        "}",
        "",
        sep = "\n",
        file = file.path(proj, ".Rprofile"),
        append = TRUE
      )
    }

    writeLines(
      text = c(
        paste(c("### global libraries ", rep("=", 79)), collapse = ""),
        "library(targets)",
        "library(tarchetypes)",
        "library(here)",
        "library(data.table)",
        "# library(future)",
        "# library(future.callr)",
        "",
        "# tar_option_set(cue = tar_cue(mode = \"never\"))",
        "",
        "# targets::tar_renv(extras = \"visNetwork\", path = \"scripts/_dependencies.R\")",
        "",
        "",
        paste(c("### project setup ", rep("=", 82)), collapse = ""),
        "invisible(sapply(",
        "  X = list.files(here(\"scripts\"), pattern = \"^tar-.*R$\", full.names = TRUE),",
        "  FUN = source, echo = FALSE",
        "))",
        "",
        "# plan(future.callr::callr, workers = 40)",
        "# plan(multicore, workers = 40)",
        "# message(sprintf(\"Number of workers: %d\", future::nbrOfWorkers()))",
        "# setDTthreads(threads = 1)",
        "",
        "",
        paste(c("### targets setup ", rep("=", 82)), collapse = ""),
        "tar_setup <- list(",
        "  tar_target(project, dirname(here()), packages = \"here\"),",
        "  tar_target(author, \"UMR1283\")",
        ")",
        "",
        "",
        paste(c("### targets ", rep("=", 88)), collapse = ""),
        "list(",
        "  tar_setup,",
        "  tar_target(start, \"hello!\")",
        ")"
      ),
      con = file.path(proj, "_targets.R")
    )
  })

  invisible(TRUE)
}

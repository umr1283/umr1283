#' @keywords internal
use_readme <- function(analyst_name, project_call, project = ".") {
  proj <- normalizePath(project, mustWork = FALSE)

  withr::with_dir(proj, {
    file <- "README.md"
    if (!file.exists(file)) {
      writeLines(
        con = file,
        text = c(
          paste("#", basename(proj)),
          paste("Created:", Sys.time()),
          paste("Analyst:", analyst_name),
          paste(c("Affiliation:\n", paste("-", use_affiliation())), collapse = "\n"),
          "# Description",
          paste0(
            "This project was setup using `umr1283` `",
            utils::packageVersion("umr1283"),
            "` (<https://github.com/umr1283/umr1283>)."
          ),
          paste(
            "```r",
            paste0("R --quiet --no-save --no-restore -e '", deparse1(project_call), "'"),
            "```",
            sep = "\n"
          ),
          "# Bash Function to Run Docker Container",
          paste(
            "```bash",
            paste0("PROJECT=\"", basename(proj), "\""),
            "SCRIPT=\"00-targets.R\"",
            "docker stop ${USER}--${PROJECT}--${SCRIPT}.R",
            "",
            "docker run \\ ",
            "  --name \"${USER}--${PROJECT}--${SCRIPT}\" \\ ",
            "  --group-add staff \\ ",
            "  --detach \\ ",
            "  --rm \\ ",
            "  --env \"RENV_PATHS_CACHE=/renv_cache\" \\ ",
            "  # --volume /media/datatmp/dockertmp/${USER}--${PROJECT}--${SCRIPT}:/tmp \\ ",
            "  --volume /media/datatmp/dockertmp/renv_pkgs_cache:/renv_cache \\ ",
            "  --volume /media:/media \\ ",
            "  --volume /etc/localtime:/etc/localtime \\ ",
            "  --volume /media/run:/disks/RUN \\ ",
            "  --volume /media/project/${PROJECT}:/disks/PROJECT/${PROJECT} \\ ",
            "  docker.io/umr1283/umr1283:4.2.0 /bin/bash -c \"cd /disks/PROJECT/${PROJECT}; Rscript scripts/${SCRIPT} >& logs/${SCRIPT}.log;\"",
            "```",
            sep = "\n"
          )
        ),
        sep = "\n\n"
      )
    } else {
      message(sprintf("\"%s\" already exists! Nothing was done!", file))
    }
  })
  invisible(TRUE)
}

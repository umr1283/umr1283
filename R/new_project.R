#' new_project
#'
#' @param path character
#' @param analyst_name character
#' @param working_directory character
#' @param git_repository character
#' @param ... not used
#'
#' @return NULL
#' @export
new_project <- function(
  path,
  analyst_name = "Not specified",
  working_directory = "/disks/DATATMP",
  git_repository = "https://github.com/mcanouil/umr1283",
  ...
) {
  path <- normalizePath(path)
  project_directory <- gsub("~", "", dirname(path))
  project_name <- basename(path)
  dir.create(
    path = path,
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  invisible(sapply(
    X = file.path(project_directory, project_name, c("docs", "reports", "scripts", "logs", "renv")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  ))

  invisible(sapply(
    X = file.path(working_directory, project_name, c("outputs", "library")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  ))

  file.symlink(
    from = file.path(working_directory, project_name, "outputs"),
    to = file.path(project_directory, project_name, "outputs")
  )
  file.symlink(
    from = file.path(working_directory, project_name, "library"),
    to = file.path(project_directory, project_name, "renv", "library")
  )

  readme <- paste(
    paste("#", project_name),
    paste("Analyst:", analyst_name),
    paste(
      "<!--",
      "1. Set default MRAN",
      "``` r",
      paste0('options(repos = c(CRAN = "https://mran.microsoft.com/snapshot/', Sys.Date(), '"))'),
      "```",
      "2. Initialise `renv`",
      "``` r",
      "renv::init()",
      "```",
      "3. Commit/push new created files",
      "``` bash",
      'git status',
      'git add --all',
      'git commit -m "init renv"',
      'git push origin master',
      "```",
      "4. Install R packages (from CRAN/MRAN, Github or BioConductor)",
      "``` r",
      'renv::install()',
      "```",
      "5. Update `renv`",
      "``` r",
      "renv::snapshot()",
      "```",
      "6. Restore previous state",
      "``` r",
      "renv::restore()",
      "```",
      "7. Revert to previous state",
      "``` r",
      "renv::revert()",
      "```",
      "8. Update R packages",
      "``` r",
      "renv::update()",
      "```",
      "-->",
      sep = "\n"
    ),
    paste(
      "<!--",
      "## Design",
      "",
      "``` bash",
      "nohup Rscript scripts/01-design.R > logs/01.log &",
      "```",
      "",
      "## Quality Control",
      "",
      "``` bash",
      'nohup Rscript -e \'rmarkdown::render(input = here::here("scripts", "02-qc.Rmd"), output_file = "QC.html", output_dir = here::here("reports"), encoding = "UTF-8")\' > logs/02.log &',
      "```",
      "",
      "## Analyses",
      "",
      "``` bash",
      "nohup Rscript scripts/03-analysis.R > logs/03.log &",
      "```",
      "-->",
      sep = "\n"
    ),
    sep = "\n\n"
  )

  writeLines(readme, con = file.path(project_directory, project_name, "README.md"))

  rproj <- c(
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
    "RnwWeave: knitr",
    "LaTeX: pdfLaTeX",
    "",
    "AutoAppendNewline: Yes",
    "LineEndingConversion: Posix",
    "",
    "QuitChildProcessesOnExit: Yes"
  )
  writeLines(rproj, con = file.path(project_directory, project_name, paste0(project_name, ".Rproj")))

  gitignore <- c(
    ".Rproj.user",
    "**.Rhistory",
    "**.RData",
    "**.Rdata",
    "**.Ruserdata",
    "**.rdb",
    "**.rdx",
    "**.glo",
    "**.ist",
    "**.out",
    "**.nav",
    "**.log",
    "**.bbl",
    "**.blg",
    "**.aux",
    "**.toc",
    "**.snm",
    "outputs",
    "logs",
    "reports"
  )
  writeLines(gitignore, con = file.path(project_directory, project_name, ".gitignore"))

  # renv::init(project = path, force = TRUE)

  Sys.chmod(
    paths = list.files(
      path = file.path(project_directory, project_name),
      recursive = TRUE, all.files = TRUE, include.dirs = TRUE,
      full.names = TRUE
    ),
    mode = "0775",
    use_umask = FALSE
  )

  invisible(capture.output({
    sapply(
      X = paste("git -C", file.path(project_directory, project_name), c(
        "init",
        "add --all",
        "commit -am 'create project'",
        "config --local core.sharedRepository 0775",
        paste(
          "push --set-upstream",
          gsub("https*://(.*)/(.*)", paste0("git@\\1:\\2/", project_name, ".git"), git_repository),
          "master"
        ),
        paste0(
          "remote add origin ", gsub("https*://(.*)/(.*)", "git@\\1:\\2", git_repository),
          "/", project_name, ".git"
        ),
        "push origin master"
      )),
      FUN = system, intern = TRUE
    )
  }))

  invisible()
}

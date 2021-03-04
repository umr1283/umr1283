#' new_project
#'
#' @param path A character string. A path to where the project is to be created.
#' @param analyst_name A character string. The name of the analyst in charge of that project.
#' @param working_directory A character string. A path to where outputs is to be generated.
#' @param git_repository A character string. URL to the git server/repository.
#' @param ... not used
#'
#' @return NULL
#' @export
new_project <- function(
  path,
  analyst_name,
  working_directory,
  git_repository,
  ...
) {
  old_repos <- getOption("repos")
  on.exit(options(repos = old_repos))

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
      "## Statistical Analyses",
      "",
      "``` bash",
      "nohup Rscript scripts/03-analysis.R > logs/03.log &",
      "```",
      "",
      "## Meeting Slides",
      "",
      paste("###", Sys.Date()),
      "",
      "``` bash",
      paste0('nohup Rscript -e \'rmarkdown::render(input = here::here("scripts", "', gsub("-", "", Sys.Date()), '-meeting.Rmd"), output_dir = here::here("reports"))\' > logs/', gsub("-", "", Sys.Date()), '-meeting.log &'),
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

  writeLines(
    text = 'library("BiocManager")',
    con = file.path(project_directory, project_name, "scripts", "00-dependencies.R")
  )

  current_repos <- list(CRAN = paste0("https://mran.microsoft.com/snapshot/", Sys.Date()))
  options(repos = current_repos)
  renv::scaffold(project = file.path(project_directory, project_name), repos = current_repos)

  cat(
    'options("BiocManager.check_repositories" = FALSE, BiocManager.snapshots = "MRAN")\n',
    'Sys.umask("0002")\n',
    file = file.path(project_directory, project_name, ".Rprofile"),
    append = TRUE
  )

  BiocManager <- package_version(utils::available.packages(repos = getOption("repos"))["BiocManager", "Version"])

  options("BiocManager.check_repositories" = FALSE, BiocManager.snapshots = "MRAN")

  renv::install(
    packages = if (BiocManager > "1.30.10") "BiocManager" else "Bioconductor/BiocManager",
    project = file.path(project_directory, project_name),
    library = file.path(
      project_directory, project_name,
      "renv", "library",
      paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
      R.Version()[["platform"]]
    ),
    prompt = FALSE
  )

  renv::install(
    packages = "here",
    project = file.path(project_directory, project_name),
    library = file.path(
      project_directory, project_name,
      "renv", "library",
      paste0("R-", R.Version()[["major"]], ".", gsub("\\..*", "", R.Version()[["minor"]])),
      R.Version()[["platform"]]
    ),
    prompt = FALSE
  )

  renv::snapshot(
    project = file.path(project_directory, project_name),
    packages = c("renv", "BiocManager", "here"),
    prompt = FALSE,
    type = "all"
  )

  invisible(sapply(
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
    FUN = system, ignore.stdout = TRUE, ignore.stderr = TRUE
  ))

  Sys.chmod(
    paths = file.path(project_directory, project_name),
    mode = "0775",
    use_umask = FALSE
  )

  Sys.chmod(
    paths = list.files(
      path = file.path(project_directory, project_name),
      recursive = TRUE, all.files = TRUE, include.dirs = TRUE,
      full.names = TRUE
    ),
    mode = "0775",
    use_umask = FALSE
  )

  invisible()
}

#' new_project
#'
#' @param project_name
#' @param analyst_name
#' @param project_directory
#' @param working_directory
#' @param git_repository
#' @param ...
#'
#' @return logical
#' @export
new_project <- function(
  project_name,
  analyst_name = "not specified",
  project_directory = "/disks/PROJECT",
  working_directory = "/disks/DATATMP",
  git_repository = "git@gitlab.egid.local:BioStat",
  ...
)  {

  sapply(
    X = file.path(project_directory, project_name, c("Docs", "Report", "Scripts")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  file.symlink(
    from = file.path(working_directory, project_name),
    to = file.path(project_directory, project_name, "Data")
  )

  readme <- paste(
    paste("#", project_name),
    paste("Analyst: ", analyst_name),
    sep = "\n"
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
    "",
    "QuitChildProcessesOnExit: Yes"
  )
  writeLines(rproj, con = file.path(project_directory, project_name, paste0(project_name, ".txt")))

  gitignore <- c(
    "**.Rproj.user",
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
    "Data",
    "/Scripts/*.html",
    "/Scripts/*.pdf"
  )
  writeLines(gitignore, con = file.path(project_directory, project_name, ".gitignore"))

  sapply(
    X = paste("git -C", file.path(project_directory, project_name), c(
      "init",
      "add --all",
      "commit -am 'create project'",
      "config --local core.sharedRepository 0775",
      paste0("remote add origin ", git_repository, "/", project_name, ".git")
    )),
    FUN = system
  )

  TRUE
}

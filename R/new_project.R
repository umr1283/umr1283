#' new_project
#'
#' @param path character
#' @param analyst_name character
#' @param working_directory character
#' @param git_repository character
#' @param ... not used
#'
#' @return logical
#' @export
new_project <- function(
  path,
  analyst_name = "Not specified",
  working_directory = "/disks/DATATMP",
  git_repository = "https://github.com/mcanouil/umr1283",
  ...
)  {
  project_directory <- gsub("~", "", dirname(path))
  project_name <- basename(path)
  dir.create(
    path = path,
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  sapply(
    X = file.path(project_directory, project_name, c("docs", "reports", "scripts", "logs")),
    FUN = dir.create, recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )
  dir.create(
    path = file.path(working_directory, project_name),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )

  file.symlink(
    from = file.path(working_directory, project_name),
    to = file.path(project_directory, project_name, "data")
  )

  readme <- paste(
    paste("#", project_name),
    paste("Analyst: ", analyst_name),
    paste0(
      '<!-- TO DELETE\n',
      'Please setup a new "Internal" project on GitLab ',
      '(', git_repository,') ',
      'named: ', project_name,
      '\n-->'
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
    "data",
    "logs"
  )
  writeLines(gitignore, con = file.path(project_directory, project_name, ".gitignore"))

  sapply(
    X = paste("git -C", file.path(project_directory, project_name), c(
      "init",
      "add --all",
      "commit -am 'create project'",
      "config --local core.sharedRepository 0775",
      paste0(
        "remote add origin ", gsub("https*://(.*)/(.*)", "git@\\1:\\2", git_repository),
        "/", project_name, ".git"
      )
    )),
    FUN = system
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

  message(paste0(
    'Please setup a new "Internal" project on GitLab ',
    '(', gsub("^.*@(.*):.*", "\\1", git_repository),') ',
    'named: ', project_name
  ))
  if (interactive()) {
    if (grepl("gitlab", git_repository)) {
      git_repository <- paste0(dirname(git_repository), "/projects/new")
    }
    utils::browseURL(git_repository)
  }

  TRUE
}

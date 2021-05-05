#' Send file using fexsend
#'
#' Documentation available at https://fex.belwue.de/fstools/fexsend.html
#'
#' @param ... One or several path to files. A zip archive is created when several path are provided,
#' @param zip_file Name of the archive created when several path are provided.
#'     Default `"20XX-XX-XX_archive.zip"`.
#' @param internal_fex If internal fexsend binary should be used. Default `TRUE`.
#'
#' @return The URL of the upload file.
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'   fex("file1.txt", "file2.txt", internal_fex = FALSE)
#' }
#'
fex <- function(..., zip_file = sprintf("%s_archive.zip", Sys.Date()), internal_fex = TRUE) {
  paths <- normalizePath(unlist(list(...), recursive = TRUE))

  zip_file <- file.path(tempdir(), zip_file)

  if (length(paths) > 1) {
    if (.Platform$OS.type == "windows") {
      parent_directory <- unique(sub(
        pattern = sprintf(
          "((([^\\\\]*\\\\){%s})(.*))",
          min(sapply(strsplit(x = paths, split = "\\\\"), length)) - 1
        ),
        replacement = "\\2",
        x = paths
      ))
    } else {
      parent_directory <- unique(sub(
        pattern = sprintf(
          "((/*([^/]*/){%s})(.*))",
          min(sapply(strsplit(x = paths, split = "/"), length)) - (any(grepl("^/", paths)) + 1)
        ),
        replacement = "\\2",
        x = paths
      ))
    }
    if (length(parent_directory) == 1) {
      withr::with_dir(new = parent_directory, code = {
        utils::zip(zipfile = zip_file, files = sub(parent_directory, "", paths))
      })
    } else {
      utils::zip(zipfile = zip_file, files = paths)
    }
    file_out <- zip_file
  } else {
    file_out <- paths
  }

  if (!file.exists(file_out)) {
    stop(sprintf('"%s" does not exist!', file_out))
  }

  if (internal_fex) {
    fexsend <- system.file("fex", "fexsend", package = "umr1283")
  } else {
    fexsend <- "fexsend"
  }

  is_fex_available <- system(
    command = sprintf("%s -V", fexsend),
    ignore.stdout = TRUE,
    ignore.stderr = TRUE
  ) == 0

  if (!is_fex_available) {
    stop(
      "fexsend must be installed!\n",
      "Documentation available at https://fex.belwue.de/fstools/fexsend.html\n",
      "Binary can be downloaded from:\n",
      "  - F*EX (Frams's Fast File EXchange) server webpage (recommended)\n",
      "  - Software webpage: https://fex.belwue.de/fstools/bin/fexsend"
    )
  }

  is_fex_configured <- system(
    command = sprintf("%s -S", fexsend),
    ignore.stdout = TRUE,
    ignore.stderr = TRUE
  ) == 0
  if (!is_fex_configured) stop("fexsend must be configured!")

  fex_out <- system(sprintf("%s %s .", fexsend, zip_file), intern = TRUE)
  unlink(zip_file, force = TRUE)

  fex_url <- gsub("Location: ", "", grep("Location:", fex_out, value = TRUE))
  message(fex_url, appendLF = TRUE)

  invisible(fex_url)
}

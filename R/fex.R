# fex <- function(path) {
#   if (length(path) > 1) {
#     zip(zipfile = zip_file, files = path)
#
#   }
#
#
#   is_fex_available <- all(sapply(
#     X = sprintf("fexsend -%s", c("V", "S")),
#     FUN = system,
#     ignore.stdout = TRUE,
#     ignore.stderr = TRUE
#   ) == 0)
#
#   if (!is_fex_available) {
#     stop(
#       "fexsend must be installed and configured!\n",
#       "Documentation available at https://fex.belwue.de/fstools/fexsend.html\n",
#       "Binary can be downloaded from:\n",
#       "  - F*EX (Frams's Fast File EXchange) server webpage (recommended)\n",
#       "  - Software webpage: https://fex.belwue.de/fstools/bin/fexsend"
#     )
#   }
#
#   fex_out <- system(paste("fexsend", zip_file, "."), intern = TRUE)
#   unlink(zip_file, force = TRUE)
#   fex_url <- gsub("Location: ", "", grep("Location:", fex_out, value = TRUE))
#   message(fex_url, appendLF = TRUE)
#   invisible(fex_url)
# }
#
# withr::with_dir(new = output_directory, code = {
#   fex <- function(zip_file) {
#     is_fex_available <- all(sapply(
#       X = sprintf("fexsend -%s", c("V", "S")),
#       FUN = system,
#       ignore.stdout = TRUE,
#       ignore.stderr = TRUE
#     ) == 0)
#
#     if (!is_fex_available) {
#       stop(
#         "fexsend must be installed and configured!\n",
#         "Documentation available at https://fex.belwue.de/fstools/fexsend.html\n",
#         "Binary can be downloaded from:\n",
#         "  - F*EX (Frams's Fast File EXchange) server webpage (recommended)\n",
#         "  - Software webpage: https://fex.belwue.de/fstools/bin/fexsend"
#       )
#     }
#
#     fex_out <- system(paste("fexsend", zip_file, "."), intern = TRUE)
#     unlink(zip_file, force = TRUE)
#     fex_url <- gsub("Location: ", "", grep("Location:", fex_out, value = TRUE))
#     message(fex_url, appendLF = TRUE)
#     invisible(fex_url)
#   }
#
#   zip_file <- sprintf("%s_%s_%s.zip",
#     gsub("-", "", Sys.Date()),
#     project_name,
#     gsub("[0-9]+\\-", "", basename(getwd()))
#   )
#   zip(
#     zipfile = zip_file,
#     files = list.files(pattern = "\\.png$|\\.xlsx$")
#   )
#   fex(zip_file)
# })

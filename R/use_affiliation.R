#' Inserm U1283 - CNRS UMR 8199 Affiliation
#'
#' @return A character vector string with the current affiliation.
#' @export
#' @examples
#' use_affiliation()
use_affiliation <- function() {
  paste(
    c(
      paste(
        "Inserm U1283",
        "CNRS UMR 8199",
        "European Genomic Institute for Diabetes (EGID)",
        "Institut Pasteur de Lille",
        sep = ", "
      ),
      paste(
        "University of Lille",
        "Lille University Hospital",
        sep = ", "
      )
    ),
    "Lille, F-59000, France.",
    sep = ", "
  )
}

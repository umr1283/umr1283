#' Use UMR1283-8199 Affiliation
#'
#' @return A character string with the current affiliation.
#' @export
#' @examples
#' use_affiliation()
use_affiliation <- function() {
  paste(
    "Inserm U1283",
    "CNRS UMR 8199",
    "European Genomic Institute for Diabetes (EGID)",
    "Institut Pasteur de Lille",
    "University of Lille",
    "Lille University Hospital",
    "Lille, F-59000, France.",
    sep = ", "
  )
}

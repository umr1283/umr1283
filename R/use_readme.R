#' @keywords internal
use_readme <- function(project, analyst_name) {
  file <- file.path(project, "README.md")
  if (!file.exists(file)) {
    writeLines(
      con = file,
      text = paste(
        paste("#", basename(project)),
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
    )
  } else {
    message(sprintf('"%s" already exists! Nothing was done!', file))
  }
}

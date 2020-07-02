#' ioslides_presentation
#'
#' Format for converting from R Markdown to an [ioslides](https://code.google.com/p/io-2012-slides/) presentation.
#'
#' @inheritParams rmarkdown::ioslides_presentation
#' @param csl bibliography style as a csl file.
#' @param ... Arguments to be passed to a specific output format function `rmarkdown::ioslides_presentation`
#'
#' @return R Markdown output format to pass to render
#' @export
ioslides_presentation <- function(
  logo = NULL,
  slide_level = 2,
  incremental = FALSE,
  fig_width = 5.94,
  fig_height = 3.30,
  fig_retina = 2,
  fig_caption = TRUE,
  dev = "png",
  df_print = "default",
  smart = TRUE,
  self_contained = TRUE,
  widescreen = FALSE,
  smaller = FALSE,
  transition = "default",
  mathjax = "default",
  analytics = NULL,
  template = NULL,
  css = NULL,
  includes = NULL,
  keep_md = FALSE,
  lib_dir = NULL,
  md_extensions = NULL,
  pandoc_args = NULL,
  extra_dependencies = NULL,
  csl = NULL,
  ...
) {
  args <- c()
  if (widescreen) {
    args <- c(args, "--variable", "widescreen")
  }
  if (identical(df_print, "paged")) {
    extra_dependencies <- append(extra_dependencies, list(rmarkdown::html_dependency_pagedtable()))
  }
  if (is.numeric(transition)) {
    transition <- as.character(transition)
  } else if (transition %in% c("default", "faster", "slower")) {
    transition <- switch(transition, default = "0.4", faster = "0.2", slower = "0.6")
  } else {
    stop("transition must be \"default\", \"faster\", \"slower\" or a ",
      "numeric value (representing seconds)",
      call. = FALSE
    )
  }
  args <- c(args, rmarkdown::pandoc_variable_arg("transition", transition))
  if (is.null(css)) {
    css <- c(
      system.file("rmarkdown/templates/ioslides/resources", "mc_theme.css", package = "mctemplates"),
      system.file("rmarkdown/templates/ioslides/resources", "all.min.5.11.2.css", package = "mctemplates")
    )
  }
  for (css_file in css) args <- c(args, "--css", rmarkdown::pandoc_path_arg(css_file))
  args <- c(args, rmarkdown::includes_to_pandoc_args(includes))
  if (is.null(template) || !file.exists(template)) {
    template <- rmarkdown:::pkg_file("rmd/ioslides/default.html")
  }
  args <- c(args, "--template", rmarkdown::pandoc_path_arg(template))
  extra_dependencies <- append(extra_dependencies, list(rmarkdown:::html_dependency_ioslides()))
  if (!is.null(analytics)) {
    args <- c(args, rmarkdown::pandoc_variable_arg("analytics", analytics))
  }
  if (is.null(csl)) {
    csl <- system.file("rmarkdown/templates/ioslides/resources", "csl", "apa.csl", package = "mctemplates")
    if (!is.null(pandoc_args) && grepl("--csl", pandoc_args)) {
      pandoc_args[grepl("--csl", pandoc_args)] <- paste0("--csl=", rmarkdown:::normalized_relative_to(dir = , file = csl))
    } else {
      pandoc_args <- c(pandoc_args, paste0("--csl=", rmarkdown:::normalized_relative_to(dir = , file = csl)))
    }
  }
  pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    if (is.null(lib_dir)) {
      lib_dir <- files_dir
    }
    args <- c()
    if (!rmarkdown:::dir_exists(files_dir)) {
      dir.create(files_dir)
    }
    if (is.null(logo)) {
      logo <- system.file("rmarkdown/templates/ioslides/resources", "logo_UMR.png", package = "mctemplates")
    }
    if (!is.null(logo)) {
      logo_path <- logo
      if (!self_contained) {
        logo_ext <- tools::file_ext(logo)
        if (nchar(logo_ext) < 1) {
          logo_ext <- "png"
        }
        logo_path <- file.path(files_dir, paste("logo", logo_ext, sep = "."))
        file.copy(from = logo, to = logo_path)
        logo_path <- rmarkdown:::normalized_relative_to(output_dir, logo_path)
      }
      else {
        logo_path <- rmarkdown::pandoc_path_arg(logo_path)
      }
      args <- c(args, "--variable", paste("logo=", logo_path, sep = ""))
    }
    args
  }
  post_processor <- function(metadata, input_file, output_file, clean, verbose) {
    args <- c()
    args <- c(args, pandoc_args)
    lua_writer <- file.path(dirname(input_file), "ioslides_presentation.lua")
    if (!file.create(lua_writer, showWarnings = FALSE)) {
      lua_writer <- file.path(dirname(output_file), basename(lua_writer))
    }
    on.exit(unlink(lua_writer), add = TRUE)
    run_citeproc <- rmarkdown:::citeproc_required(metadata, rmarkdown:::read_utf8(input_file))
    settings <- c()
    add_setting <- function(name, value) {
      settings <<- c(settings, paste("local", name, "=", ifelse(value, "true", "false")))
    }
    add_setting("fig_caption", fig_caption)
    add_setting("incremental", incremental)
    add_setting("smaller", smaller)
    add_setting("smart", smart)
    add_setting("mathjax", !is.null(mathjax))
    settings <- c(settings, sprintf("local slide_level = %s", slide_level))
    rmarkdown:::write_utf8(settings, lua_writer)
    args <- c(args, "--slide-level", as.character(slide_level))
    file.append(lua_writer, rmarkdown:::pkg_file("rmd/ioslides/ioslides_presentation.lua"))
    output_tmpfile <- tempfile("ioslides-output", fileext = ".html")
    on.exit(unlink(output_tmpfile), add = TRUE)
    if (rmarkdown:::is_windows()) {
      codepage <- as.numeric(gsub("\\D", "", system2("chcp", stdout = TRUE)))
      if (!is.na(codepage)) {
        on.exit(system2("chcp", args = codepage, stdout = TRUE), add = TRUE)
        system2("chcp", args = 65001, stdout = TRUE)
      }
    }
    rmarkdown::pandoc_convert(
      input = input_file,
      to = rmarkdown::relative_to(dirname(input_file), lua_writer),
      from = rmarkdown::from_rmarkdown(fig_caption),
      output = output_tmpfile,
      options = args,
      citeproc = run_citeproc,
      verbose = verbose
    )
    slides_lines <- rmarkdown:::read_utf8(output_tmpfile)
    if (self_contained) {
      slides_lines <- rmarkdown:::base64_image_encode(slides_lines)
    }
    output_lines <- rmarkdown:::read_utf8(output_file)
    sentinel_line <- grep("^RENDERED_SLIDES$", output_lines)
    if (length(sentinel_line) == 1) {
      preface_lines <- c(output_lines[1:sentinel_line[1] - 1])
      suffix_lines <- c(output_lines[-(1:sentinel_line[1])])
      output_lines <- c(preface_lines, slides_lines, suffix_lines)
      rmarkdown:::write_utf8(output_lines, output_file)
    } else {
      stop("Slides placeholder not found in slides HTML", call. = FALSE)
    }
    output_file
  }
  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options_html(fig_width, fig_height, fig_retina, keep_md, dev),
    pandoc = rmarkdown::pandoc_options(to = "html", from = rmarkdown::from_rmarkdown(fig_caption, md_extensions), args = args),
    keep_md = keep_md,
    clean_supporting = self_contained,
    df_print = df_print,
    pre_processor = pre_processor,
    post_processor = post_processor,
    base_format = rmarkdown::html_document_base(
      lib_dir = lib_dir,
      self_contained = self_contained,
      mathjax = mathjax,
      pandoc_args = pandoc_args,
      extra_dependencies = extra_dependencies,
      bootstrap_compatible = TRUE,
      ...
    )
  )
}

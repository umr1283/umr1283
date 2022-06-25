# UMR 1283 - Project Template <a href='https://umr1283.github.io/umr1283'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->
[![GitHub
tag](https://img.shields.io/github/tag/umr1283/umr1283.svg?label=latest%20tag&include_prereleases)](https://github.com/umr1283/umr1283)
[![R-CMD-check](https://github.com/umr1283/umr1283/actions/workflows/check-pak.yaml/badge.svg)](https://github.com/umr1283/umr1283/actions/workflows/check-pak.yaml)
<!-- badges: end -->

You can install `umr1283` with:

``` r
remotes::install_github("umr1283/umr1283")
```

The default project directory from `umr1283::create_project` (compatible
with RStudio Project Wizard) is as follow:

``` text
.
├── .devcontainer
│   ├── Dockerfile
│   └── devcontainer.json
├── data
├── docs
├── logs
├── outputs
├── renv
├── reports
├── scripts
│   └── _dependencies.R
├── slides (`xaringan = TRUE`)
├── README.md
├── renv.lock
└── project.Rproj
```

------------------------------------------------------------------------

## Getting help

If you encounter a clear bug, please file a minimal reproducible example
on [GitHub](https://github.com/umr1283/umr1283/issues).  
For questions and other discussion, please open a discussion on
[GitHub](https://github.com/umr1283/umr1283/discussions).

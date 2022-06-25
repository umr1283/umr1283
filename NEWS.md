# umr1283 (development version)

# umr1283 1.9.0

## Feature

- In `R/create_project.R`,
  - Feat: add devcontainer definition files for VSCode ([#3](https://github.com/umr1283/umr1283/issues/3)).

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.8.3...v1.9.0

# umr1283 1.8.3

## Chore

- In `inst/fex/fexsend`,
  - chore: update fexsend client.

## Fixes

- In `R/fex.R`.
  - Fix: parent directory detection.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.8.2...v1.8.3

# umr1283 1.8.2

## Fixes

- In `R/use_gitignore.R`.
  - Fix: `*.Rproj` is now excluded from versionning.
- In `R/use_targets.R`,
  - Fix: default `targets` script no longer rely on `*.Rproj`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.8.1...v1.8.2

# umr1283 1.8.1

## Fixes

- In `R/use_rprofile.R`,
  - No longer hardcode settings, instead source `~/.Rprofile` if it exists and in interactive mode.
- In `DESCRIPTION`,
  - Bump (minor) version of dependencies.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.8.0...v1.8.1

# umr1283 1.8.0

## Breaking change

- Remove Python wrapper. (3fedb3a961984d7b165a258e08e11d366794cb78)
  - In `R/use_python.R`.
  - In `R/create_project.R`.
  - In `R/use_dir_structure.R`.
  - In `R/migrate_project.R`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.7.0...v1.8.0

# umr1283 1.7.0

## Features

- In `R/create_project.R`,
  - Allows to use directory within the project (when `working_directory` is `NULL` or `""`) or symbolic link (058ade53e66482426a8ded231fe2e3553a6dc4a2).
  - Allows to install `xaringan` template when creating a project (37a417c20c391a1c66b4648fe55b5c7ea4d2bf7f).

## Fixes

- In `R/use_rprofile.R`,
  - Fix duplicated `targets` lines in `.Rprofile` (2f8c90b78749a02861fdaf7285364899abc10ec4).
- In `R/use_rprofile.R`,
  - Fix duplicated `.gitignore` entry for `targets` (c2cc1d51ee7b564fe27223a1e838637b8c096869).
  - No longer exclude "outputs" and "logs" (c2cc1d51ee7b564fe27223a1e838637b8c096869).
- In `R/use_python.R`,
  - Fix unused arguments (fa21f5fbed0638c65da16c8146854b87bb8d73d2).
- In `R/use_targets.R`,
  - Fix unused arguments (13055f3cc8d3a0b5bee609cb4085329698824d42).
- In `R/use_dir_structure.R`,
  - Fix unused arguments (ab94c2499b4cb989f09adf0434c04c5b20719f51).
- In `R/migrate_project.R`,
  - Add a warning message to "discourage" the use of `migrate_project` (416e79a0d7499433efde68a13809cb8923e5bbe4).
  - Remove default parameter value for `working_directory` (fc34b29d999ad1e631e5c37e4649b2ac4ff682fb).

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.6.0...v1.7.0

# umr1283 1.6.0

- In `R/fex.R`,
  - Fix URL for `pkgdown` website.
- In `R/create_project.R`,
  - No longer create external `renv` "library" directory.
  - Use a dedicated directory for `slides`.

    ```text
    /disks/PROJECT/project
    ├── data
    ├── docs
    ├── scripts
    │   └── _dependencies.R
    ├── reports
    ├── slides
    ├── outputs (symlink to /disks/DATATMP/project/outputs)
    ├── logs
    ├── renv
    ├── README.md
    ├── renv.lock
    └── project.Rproj
    ```

- In `R/use_targets.R`,
  - Add `gittargets`.
  - No longer use symbolic link for targets store.
- In `R/use_python.R`,
  - No longer use symbolic link for python library.
- In `R/use_xaringan.R`,
  - Default directory to `slides` in the current working directory.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.5.1...v1.6.0

# umr1283 1.5.1

- In `R/create_project.R`,
  - Add check before creating symbolic link.
- In `R/migrate_project.R`,
  - Add check before creating symbolic link.
- In `R/use_dir_structure.R`,
  - Add check before creating symbolic link.
  - No longer install R packages, but add a message to install them manually.
- In `R/use_git.R`,
  - Add check before creating symbolic link.
- In `R/use_python.R`,
  - Add check before creating symbolic link.
- In `R/targets.R`,
  - Add check before creating symbolic link.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.5.0...v1.5.1

# umr1283 1.5.0

- In `R/create_project.R`,
  - Remove library symbolic link.
- In `R/use_gitignore.R`,
  - No longer exclude reports directory by default.
  - Exclude renv directory properly.
- In `R/use_rprofile.R`,
  - No longer load `gert` by default (if installed).

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.4.0...v1.5.0

# umr1283 1.4.0

- In `R/*`,
  - Fix `lintr` warnings.
- In `R/use_dir_structure.R`,
  - No longer try to install `BiocManager` or `here` by default.
  - Install `here` and `tarchetypes` by default when `targets` is required.
- In `R/use_dependencies.R`,
  - Create empty file, i.e., without `# library("BiocManager")`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.3.1...v1.4.0

# umr1283 1.3.1

- In `inst/fex/fexsend`,
  - Updated `fexsend` (http://fex.belwue.de/download/fexsend).
- In `DESCRIPTION`,
  - Add `SystemRequirements` for fexsend.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.3.0...v1.3.1

# umr1283 1.3.0

- In `DESCRIPTION`,
  - Tweak description and title.
  - Tidy dependencies.
  - Update packages.
- In `R/use_gitignore.R`,
  - Add "core".
- In `R/use_git.R`,
  - Do not do anything if `.git` directory exists.
- In `R/use_dir_structure.R`,
  - Do not do anything if `.Rprofile` contains `source("renv/activate.R")`.
- In `R/create_project.R`,
  - Add "data" directory.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.2.3...v1.3.0

# umr1283 1.2.3

- In `DESCRIPTION`,
  - Remove "RStudio" from title.
- In `R/use_xaringan.R`,
  - Avoid copying `README.Rmd`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.2.2...v1.2.3

# umr1283 1.2.2

- In `DESCRIPTION`,
  - Remove unnecessary `LazyData` field.
- In `R/use_targets.R`,
  - Fix typo/bug in `_targets.R` template script.
  - Edit `.Rprofile` (if it exists) with shortcut for targets.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.2.1...v1.2.2

# umr1283 1.2.1

- In `R/fex.R`,
  - Fix output when only one file is provided.
  - Improve example.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.2.0...v1.2.1

# umr1283 1.2.0

- In `R/use_xaringan.R`,
  - Download `xaringan` (https://github.com/umr1283/xaringan-template) template to `scripts/slides`.
- In `R/migrate_project.R`,
  - Fix typo.
- In `R/use_targets.R`,
  - Fix typo.
- In `R/use_python.R`,
  - Fix typo.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.1.4...v1.2.0

# umr1283 1.1.4

- In `R/use_targets.R`,
  - Improve default targets R script skeleton.
  - Add default targets script launcher.
- In `R/use_rprofile.R`,
  - Add `targets` package in `.Rprofile`,
    if in interactive session and installed
    (locally or system-wide depending on the project setup).

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.1.3...v1.1.4

# umr1283 1.1.3

- In `R/use_affiliation.R`,
  - Split in two.
- In `R/use_readme.R`,
  - Use bullets list for affiliation.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.1.2...v1.1.3

# umr1283 1.1.2

- In `R/use_targets.R`,
  - Improve default targets R script to better work with Docker.
- In `inst/fex/fexsend`,
  - Fix permission.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.1.1...v1.1.2

# umr1283 1.1.1

- In `DESCRIPTION`,
  - Define `markdown` format for `roxygen2` documentation.
- In `R/create_project.R`,
  - Improve description.
- In `R/migrate_project.R`,
  - Improve description.
- In `R/use_affiliation.R`,
  - Improve description.
- In `R/use_targets.R`,
  - Improve description.
- In `R/use_python.R`,
  - Improve description.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.1.0...v1.1.1

# umr1283 1.1.0

- In `DESCRIPTION`,
  - Add `prompt` in `Suggests`.
- In `R/use_rprofile.R`,
  - Add `prompt` package in `.Rprofile`,
    if in interactive session and installed
    (locally or system-wide depending on the project setup).
  - Add `gert` package in `.Rprofile`,
    if in interactive session and installed
    (locally or system-wide depending on the project setup).
- In `R/use_dir_structure.R`,
  - Only load `targets`, if in interactive session and installed
   (locally or system-wide depending on the project setup).
- In `R/fex.R`,
  - New function to upload file(s) using fexsend.
- Add `pkgdown`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.0.1...v1.1.0

# umr1283 1.0.1

- In `R/use_python.R`,
  - Remove code related to `ensurepip`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v1.0.0...v1.0.1

# umr1283 1.0.0

- In `DESCRIPTION`,
  - Remove `rmarkdown` templates dependencies.
  - Add `targets` in `Suggests`.
  - Add `withr` and `callr` in `Imports`to handle project architecture.
- In `R/create_project.R` (previously `R/new_project.R`),
  - Set `BiocManager` to use MRAN with new option as of `v1.30.12`.
  - Install `here` using `renv` by default.
  - Set umask to `0002`.
  - Allow to not use MRAN for new project (default).
  - Add support for `renv::use_python()`.
  - Add support for `targets`.
  - Refactoring using use_- functions.
- In `R/migrate_project.R`,
  - Set `BiocManager` to use MRAN with new option as of `v1.30.12`.
  - Install `here` using `renv` by default.
  - Set umask to `0002`.
  - Add support for `renv::use_python()`.
  - Refactoring using use_- functions.
- In `R/use_targets.R`,
  - Create directory structure required for `targets`.
- In `R/use_python.R`,
  - Create directory structure required for `reticulate` and `Python` within `renv`.
- In `R/use_affiliation.R`,
  - Add function to get current affiliation.
- Remove [rmarkdown templates](inst/rmarkdown/templates).

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.8.1...v1.0.0

# umr1283 0.8.1

- In `R/new_project.R`,
  - Add missing documentation.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.8.0...v0.8.1

# umr1283 0.8.0

- In `DESCRIPTION`,
  - Add `renv` in `Suggests`.
- In `R/new_project.R`,
  - Add `renv` directory structure.
  - Improve project README.
  - Add push to gitlab.
  - Ensure project directory is in `0775`.
  - Default `BiocManager` install.
- In `R/migrate_project.R`,
  - New function to migrate old project to `renv` project-like.
  - Default `BiocManager` install.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.9...v0.8.0

# umr1283 0.7.9

- In `DESCRIPTION`,
  - Update dependencies.
- In `R/ioslides_presentation.R`,
  - Update not exported function from `rmarkdown`.
- In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
  - Update affiliation.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.8...v0.7.9

# umr1283 0.7.8

- In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
  - Add Font-Awesome 5.14.0 icons to ioslides.
- In `ioslides_presentation.R`,
  - Update to include Font-Awesome 5.14.0 icons.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.7...v0.7.8

# umr1283 0.7.7

- In [rmarkdown templates](inst/rmarkdown/templates),
  - Update ggplot2 template code.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.6...v0.7.7

# umr1283 0.7.6

- In [rmarkdown templates](inst/rmarkdown/templates),
  - Remove default subdirectory for intermediate Rmarkdown files.
  - Update affiliation.
- In `R/new_project.R`,
  - Add "reports" to `.gitignore`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.5...v0.7.6

# umr1283 0.7.5

- In [rmarkdown templates](inst/rmarkdown/templates),
  - Minor code change.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.4...v0.7.5

# umr1283 0.7.4

- In [rmarkdown templates](inst/rmarkdown/templates),
  - Remove css style for tables.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.3...v0.7.4

# umr1283 0.7.3

- In [rmarkdown templates](inst/rmarkdown/templates),
  - Reorder code in setup chunk.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.2...v0.7.3

# umr1283 0.7.2

- Fix knitr hook in templates.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.1...v0.7.2

# umr1283 0.7.1

- Fix outputs directory in templates.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.7.0...v0.7.1

# umr1283 0.7.0

- Fix ioslide templates.
- Update setup chunks in all templates.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.6.0...v0.7.0

# umr1283 0.6.0

- Rename `data` to `outputs`.

    ```text
    /disks/PROJECT/test
    ├── outputs -> /disks/DATATMP/test
    ├── docs
    ├── logs
    ├── reports
    ├── scripts
    ├── README.md
    ├── .git
    ├── .gitignore
    └── test.Rproj
    ```

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.5.0...v0.6.0

# umr1283 0.5.0

- Update rmarkdown templates according to project directory tree structure.
- Fix obsolete parameters in chunks of the rmarkdown templates.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.4.1...v0.5.0

# umr1283 0.4.1

- Update report template.
- Fix ressources in ioslide template.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.4.0...v0.4.1

# umr1283 0.4.0

- Add a `logs` directory.

    ```text
    /disks/PROJECT/test
    ├── data -> /disks/DATATMP/test
    ├── docs
    ├── logs
    ├── reports
    ├── scripts
    ├── README.md
    ├── .git
    ├── .gitignore
    └── test.Rproj
    ```

- Fix some style in `README.md` file.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.3.0...v0.4.0

# umr1283 0.3.0

- Set 775 permissions for files and directories

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.2.0...v0.3.0

# umr1283 0.2.0

- Remove Rmarkdown templates, now in `dgapaq`:
  - qc_impute - `UMR 1283 - QC Imputation (VCF)`.
  - qc_plink - `UMR 1283 - QC PLINK`.
- Remove Rmarkdown templates, now in `dmapaq`:
  - qc_idats - `UMR 1283 - QC idats`.

**Full Changelog**: https://github.com/umr1283/umr1283/compare/v0.1.0...v0.2.0

# umr1283 0.1.0

- Added a `NEWS.md` file to track changes to the package.
- Added a RStudio project template `UMR 1283 - RStudio Project Templates`.

    ```text
    /disks/PROJECT/test
    ├── data -> /disks/DATATMP/test
    ├── docs
    ├── reports
    ├── scripts
    ├── README.md
    ├── .git
    ├── .gitignore
    └── test.Rproj
    ```

- Added Rmarkdown templates for:
  - ioslides - `UMR 1283 - ioslides`.
  - PowerPoint - `UMR 1283 - PowerPoint`.
  - HTML report - `UMR 1283 - Report`.
  - qc_idats - `UMR 1283 - QC idats`.
  - qc_plink - `UMR 1283 - QC PLINK`.
  - qc_impute - `UMR 1283 - QC Imputation (VCF)`.

# umr1283 (development version)

* In `DESCRIPTION`,
    + Remove "RStudio" from title.

* In `R/use_xaringan.R`,
    + Avoid copying `README.Rmd`.

# umr1283 1.2.2

* In `DESCRIPTION`,
    + Remove unnecessary `LazyData` field.
* In `R/use_targets.R`,
    + Fix typo/bug in `_targets.R` template script.
    + Edit `.Rprofile` (if it exists) with shortcut for targets.

# umr1283 1.2.1

* In `R/fex.R`,
    + Fix output when only one file is provided.
    + Improve example.

# umr1283 1.2.0

* In `R/use_xaringan.R`,
    + Download `xaringan` (https://github.com/umr1283/xaringan-template) template to `scripts/slides`.
* In `R/migrate_project.R`,
    + Fix typo.
* In `R/use_targets.R`,
    + Fix typo.
* In `R/use_python.R`,
    + Fix typo.

# umr1283 1.1.4

* In `R/use_targets.R`,
    + Improve default targets R script skeleton.
    + Add default targets script launcher.
* In `R/use_rprofile.R`,
    + Add `targets` package in `.Rprofile`,
        if in interactive session and installed
        (locally or system-wide depending on the project setup).

# umr1283 1.1.3

* In `R/use_affiliation.R`,
    + Split in two.
* In `R/use_readme.R`,
    + Use bullets list for affiliation.

# umr1283 1.1.2

* In `R/use_targets.R`,
    + Improve default targets R script to better work with Docker.
* In `inst/fex/fexsend`,
    + Fix permission.

# umr1283 1.1.1

* In `DESCRIPTION`,
    + Define `markdown` format for `roxygen2` documentation.
* In `R/create_project.R`,
    + Improve description.
* In `R/migrate_project.R`,
    + Improve description.
* In `R/use_affiliation.R`,
    + Improve description.
* In `R/use_targets.R`,
    + Improve description.
* In `R/use_python.R`,
    + Improve description.

# umr1283 1.1.0

* In `DESCRIPTION`,
    + Add `prompt` in `Suggests`.
* In `R/use_rprofile.R`,
    + Add `prompt` package in `.Rprofile`,
        if in interactive session and installed
        (locally or system-wide depending on the project setup).
    + Add `gert` package in `.Rprofile`,
        if in interactive session and installed
        (locally or system-wide depending on the project setup).
* In `R/use_dir_structure.R`,
    + Only load `targets`, if in interactive session and installed
        (locally or system-wide depending on the project setup).
* In `R/fex.R`,
    + New function to upload file(s) using fexsend.
* Add `pkgdown`.

# umr1283 1.0.1

* In `R/use_python.R`,
    + Remove code related to `ensurepip`.

# umr1283 1.0.0

* In `DESCRIPTION`,
    + Remove `rmarkdown` templates dependencies.
    + Add `targets` in `Suggests`.
    + Add `withr` and `callr` in `Imports`to handle project architecture.
* In `R/create_project.R` (previously `R/new_project.R`),
    + Set `BiocManager` to use MRAN with new option as of `v1.30.12`.
    + Install `here` using `renv` by default.
    + Set umask to `0002`.
    + Allow to not use MRAN for new project (default).
    + Add support for `renv::use_python()`.
    + Add support for `targets`.
    + Refactoring using use_* functions.
* In `R/migrate_project.R`,
    + Set `BiocManager` to use MRAN with new option as of `v1.30.12`.
    + Install `here` using `renv` by default.
    + Set umask to `0002`.
    + Add support for `renv::use_python()`.
    + Refactoring using use_* functions.
* In `R/use_targets.R`,
    + Create directory structure required for `targets`.
* In `R/use_python.R`,
    + Create directory structure required for `reticulate` and `Python` within `renv`.
* In `R/use_affiliation.R`,
    + Add function to get current affiliation.
* Remove [rmarkdown templates](inst/rmarkdown/templates).

# umr1283 0.8.1

* In `R/new_project.R`,
    + Add missing documentation.

# umr1283 0.8.0

* In `DESCRIPTION`,
    + Add `renv` in `Suggests`.
* In `R/new_project.R`,
    + Add `renv` directory structure.
    + Improve project README.
    + Add push to gitlab.
    + Ensure project directory is in `0775`.
    + Default `BiocManager` install.
* In `R/migrate_project.R`,
    + New function to migrate old project to `renv` project-like.
    + Default `BiocManager` install.

# umr1283 0.7.9

* In `DESCRIPTION`,
    + Update dependencies.
* In `R/ioslides_presentation.R`,
    + Update not exported function from `rmarkdown`.
* In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
    + Update affiliation.

# umr1283 0.7.8

* In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
    + Add Font-Awesome 5.14.0 icons to ioslides.
* In `ioslides_presentation.R`,
    + Update to include Font-Awesome 5.14.0 icons.

# umr1283 0.7.7

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Update ggplot2 template code.

# umr1283 0.7.6

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Remove default subdirectory for intermediate Rmarkdown files.
    + Update affiliation.
* In `R/new_project.R`,
    + Add "reports" to `.gitignore`.

# umr1283 0.7.5

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Minor code change.

# umr1283 0.7.4

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Remove css style for tables.

# umr1283 0.7.3

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Reorder code in setup chunk.

# umr1283 0.7.2

* Fix knitr hook in templates.

# umr1283 0.7.1

* Fix outputs directory in templates.

# umr1283 0.7.0

* Fix ioslide templates.
* Update setup chunks in all templates.

# umr1283 0.6.0

* Rename `data` to `outputs`.

    ```
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

# umr1283 0.5.0

* Update rmarkdown templates according to project directory tree structure.
* Fix obsolete parameters in chunks of the rmarkdown templates.

# umr1283 0.4.1

* Update report template.
* Fix ressources in ioslide template.

# umr1283 0.4.0

* Add a `logs` directory.

   ```
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

* Fix some style in `README.md` file.

# umr1283 0.3.0

* Set 775 permissions for files and directories

# umr1283 0.2.0

* Remove Rmarkdown templates, now in `dgapaq`:
    - qc_impute - `UMR 1283 - QC Imputation (VCF)`.
    - qc_plink - `UMR 1283 - QC PLINK`.
* Remove Rmarkdown templates, now in `dmapaq`:
    - qc_idats - `UMR 1283 - QC idats`.

# umr1283 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Added a RStudio project template `UMR 1283 - RStudio Project Templates`.

    ```
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

* Added Rmarkdown templates for:
    - ioslides - `UMR 1283 - ioslides`.
    - PowerPoint - `UMR 1283 - PowerPoint`.
    - HTML report - `UMR 1283 - Report`.
    - qc_idats - `UMR 1283 - QC idats`.
    - qc_plink - `UMR 1283 - QC PLINK`.
    - qc_impute - `UMR 1283 - QC Imputation (VCF)`.

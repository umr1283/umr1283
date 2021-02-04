# umr1283 0.8.0

* In `DESCRIPTION`,
    + Add `renv` in `Suggests`.
* In `R/new_project.R`,
    + Add `renv` directory structure.
    + Improve project README.
    + Add push to gitlab.
    + Ensure project directory is in `0775`.
    + Install `BiocManager` version > 1.30.10 (with CRAN repository fix).
* In `R/migrate_project.R`,
    + New function to migrate old project to `renv` project-like.

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

## Minor improvements and fixes

* Fix ioslide templates.
* Update setup chunks in all templates.

# umr1283 0.6.0

## Minor improvements and fixes

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

## Minor improvements and fixes

* Update rmarkdown templates according to project directory tree structure.
* Fix obsolete parameters in chunks of the rmarkdown templates.

# umr1283 0.4.1

## Minor improvements and fixes

* Update report template.
* Fix ressources in ioslide template.

# umr1283 0.4.0

## Minor improvements and fixes

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

## Minor improvements and fixes

* Set 775 permissions for files and directories

# umr1283 0.2.0

## Minor improvements and fixes

* Remove Rmarkdown templates, now in `dgapaq`:
    - qc_impute - `UMR 1283 - QC Imputation (VCF)`.
    - qc_plink - `UMR 1283 - QC PLINK`.
* Remove Rmarkdown templates, now in `dmapaq`:
    - qc_idats - `UMR 1283 - QC idats`.

# umr1283 0.1.0

## New features

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

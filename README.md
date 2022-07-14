pluripotent
=========================

Repeatedly generate an embryonic repository with one command.

Like a [pluripotent stem cell](https://en.wikipedia.org/wiki/Stem_cell#Potency_meaning), this package will generate new cells/projects.  These offspring repos are more specialized, and will exist to do real work (as opposed to exist to generate more stem cells).

The [inst/metadata/file-to-copy.csv](https://github.com/OuhscBbmc/pluripotent/blob/main/inst/metadata/file-to-copy.csv) file describes the source and destination of transferred files.  The two projects currently natively supported are:

* [RAnalysisSkeleton](https://github.com/wibeasley/RAnalysisSkeleton) which is our all-purpose data science project.

* [cdw-skeleton-1](https://github.com/OuhscBbmc/cdw-skeleton-1) which is our public repo used to seed our [CDW](https://github.com/OuhscBbmc/prairie-outpost-public) analysis projects.

A new project/repo called 'beasley-poc-1' can be generated in two ways:

1. Run this single chunk of code, after updating the `project_name` and `destination_directory` arguments.

    ```r
    remotes::install_github(repo="OuhscBbmc/pluripotent")
    pluripotent::start_cdw_skeleton_1(
      project_name            = "beasley-poc-1",
      destination_directory   = "~/bbmc/cdw"
    )
    ```

1. The [cdw-template-1](https://github.com/OuhscBbmc/cdw-template-1) repo provides a platform to jump-start consistent repos for CDW projects.  Once it's used as a [GitHub template](https://help.github.com/en/articles/creating-a-repository-from-a-template), the [`utility/spawn.R`](https://github.com/OuhscBbmc/cdw-template-1/blob/main/utility/spawn.R) file contains the following dynamic code that should run without modification.

    ```r
    # Install remotes & pluripotent if not already installed.  pluripotent won't reinstall if it's already up-to-date.
    if( !requireNamespace("remotes") ) utils::install.packages("remotes")
    remotes::install_github("OuhscBbmc/pluripotent")

    # Discover repo name & parent directory.
    project_name          <- basename(normalizePath(".."))
    project_parent_path   <- normalizePath("..\\..")

    # Copy remote files to the current repo.
    pluripotent::start_cdw_skeleton_1(
    project_name          = project_name,
    destination_directory = project_parent_path
    )

    # Afterwards, close RStudio and open the *.Rproj file in the root directory.
    ```


    To spawn a cdw repo (*i.e.*, a repo whose template is [cdw-template-1](https://github.com/OuhscBbmc/cdw-template-1)):
    
    1. open `utility/spawn.R` directly in RStudio & run the whole file (*i.e.*, ctrl+shift+r)
    1. after it completes, close RStudio
    1. commit & push the repo.  A typical commit message is
        > populate repo files
        >
        > closes #1 *(or whatever issue number corresponds to 'initialize repo')*
    1. go up one directory (to the repo root) and open the *.Rproj file.
    1. Do Science :1st_place_medal: 
    
1. To update a config file that's downloaded from [the skeleton's config file](https://github.com/OuhscBbmc/cdw-skeleton-1/blob/main/config.yml), run this instead of spawning a new repo.  This scenario comes up when refitting older repos to newer standards.
    
    ```r
    pluripotent::populate_config("config.yml", basename(getwd())
    ```
    
    
<!--
If you want to use this package for projects that aren't included in [inst/metadata/file-to-copy.csv](https://github.com/OuhscBbmc/pluripotent/blob/main/inst/metadata/file-to-copy.csv) file describes the source and destination of transferred files.
-->

@andkov, as I'm describing this, I see the resemblance to a [factory pattern](https://en.wikipedia.org/wiki/Factory_(object-oriented_programming)) in software.  But the stem cell metaphor is both flowery and abstruse, which seems to be what you and I go for when we're attaching metaphors.

Installation and Documentation
--------------------------------------

The *development* version can be installed from [GitHub](https://github.com/OuhscBbmc/pluripotent) after installing the [remotes](https://CRAN.R-project.org/package=remotes) package.

```r
install.packages("pluripotent") # Run this line if the 'remotes' package isn't installed already.
remotes::install_github(repo="OuhscBbmc/pluripotent")
```

The package can be uninstalled from your local machine with `remove.packages("pluripotent")`.

Build Status and Package Characteristics
--------------------------------------

| [GitHub](https://github.com/OuhscBbmc/pluripotent) | [Travis-CI](https://travis-ci.org/OuhscBbmc/pluripotent/builds) | [AppVeyor](https://ci.appveyor.com/project/wibeasley/pluripotent/history) | [Coveralls](https://coveralls.io/r/OuhscBbmc/pluripotent) |
| :----- | :---------------------------: | :-----------------------------: | :-------: |
| [Main](https://github.com/OuhscBbmc/pluripotent/tree/main) | [![Build Status](https://travis-ci.org/OuhscBbmc/pluripotent.svg?branch=main)](https://travis-ci.org/OuhscBbmc/pluripotent) | [![Build status](https://ci.appveyor.com/api/projects/status/ie2hgogtuqom092k/branch/main?svg=true)](https://ci.appveyor.com/project/wibeasley/pluripotent/branch/main) | [![Coverage Status](https://coveralls.io/repos/github/OuhscBbmc/pluripotent/badge.svg?branch=main)](https://coveralls.io/github/OuhscBbmc/pluripotent?branch=main) |
| [Dev](https://github.com/OuhscBbmc/pluripotent/tree/dev) | [![Build Status](https://travis-ci.org/OuhscBbmc/pluripotent.svg?branch=dev)](https://travis-ci.org/OuhscBbmc/pluripotent) | [![Build status](https://ci.appveyor.com/api/projects/status/ie2hgogtuqom092k/branch/dev?svg=true)](https://ci.appveyor.com/project/wibeasley/pluripotent/branch/dev) | [![Coverage Status](https://coveralls.io/repos/github/OuhscBbmc/pluripotent/badge.svg?branch=dev)](https://coveralls.io/github/OuhscBbmc/pluripotent?branch=dev) |
| | *Ubuntu LTS* | *Windows Server* | *Test Coverage* |

| Key | Value |
| :--- | :----- |
| [License](https://choosealicense.com/) | [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) |
<!--| [Development Doc](https://www.rdocumentation.org/) | [![Rdoc](https://img.shields.io/badge/pkgodwn-GitHub.io-orange.svg?longCache=true&style=style=for-the-badge)](https://ouhscbbmc.github.io/pluripotent/) |-->
<!--| [Zenodo Archive](https://zenodo.org/search?ln=en&p=pluripotent) | [![DOI](https://zenodo.org/badge/146359325.svg)](https://zenodo.org/badge/latestdoi/146359325) |-->
<!--| [CRAN Version](https://cran.r-project.org/package=pluripotent) | [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/pluripotent)](https://cran.r-project.org/package=pluripotent) |
| [CRAN Rate](http://cranlogs.r-pkg.org/) | ![CRANPace](http://cranlogs.r-pkg.org/badges/pluripotent) |
| [Production Doc](https://www.rdocumentation.org/) | [![Rdoc](http://www.rdocumentation.org/badges/version/pluripotent)](http://www.rdocumentation.org/packages/pluripotent) |
-->

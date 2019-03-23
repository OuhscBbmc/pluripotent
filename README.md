pluripotent
=========================

Repeatedly generate an embryonic repository with one command

Like a [pluripotent stem cell](https://en.wikipedia.org/wiki/Stem_cell#Potency_meaning) this package will generate new cells/projects.  These offspring repos are more specialized, and will exist to do real work.  As opposed to exist to generate more stem cells.

The two projects I immediately want to support are 
* [RAnalysisSkeleton](https://github.com/wibeasley/RAnalysisSkeleton) which is our all-purpose data science project.
* [cdw-staging](https://github.com/OuhscBbmc/cdw-staging) which is our non-public repo used to see our analysis projects that use OUHSC's clinical data warehouse.

I hope that a new project/repo called 'patient-health' can be generated in three ways:
1. a single like of code like
    ```r
    pluripotent::seed_skeleton("~/GitHub/patient-health)
    ```
1. an RStudio [addin](https://rstudio.github.io/rstudioaddins/), which has been nice for our [OuhscMunge package](http://ouhscbbmc.github.io/OuhscMunge/reference/install_packages_addin.html)
1. a Gist-base function, like what's [worked well for installing packages](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ResourcesInstallation.md#installation-required) in a new system.  Maybe something like

    ```r
    if( !base::requireNamespace("devtools") ) utils::install.packages("devtools")
    devtools::source_gist("2c5e7459b88ec28b9e8fa0c695b15ee3", filename="seed.R")
    seed_skeleton()
    ```

@andkov, as I'm describing this, I see the resemblance to a [factory pattern](https://en.wikipedia.org/wiki/Factory_(object-oriented_programming)) in software.  But the stem cell metaphor is both flowery and abstruse, which seems to be what you and I go for when we're attaching metaphors.


### Installation and Documentation

The *development* version can be installed from [GitHub](https://github.com/OuhscBbmc/pluripotent) after installing the [remotes](https://CRAN.R-project.org/package=remotes) package.

```r
install.packages("pluripotent") # Run this line if the 'remotes' package isn't installed already.
remotes::install_github(repo="OuhscBbmc/pluripotent")
```


The package can be uninstalled from your local machine with `remove.packages("pluripotent")`.


### Build Status and Package Characteristics

| [GitHub](https://github.com/OuhscBbmc/pluripotent) | [Travis-CI](https://travis-ci.org/OuhscBbmc/pluripotent/builds) | [AppVeyor](https://ci.appveyor.com/project/wibeasley/pluripotent/history) | [Coveralls](https://coveralls.io/r/OuhscBbmc/pluripotent) |
| :----- | :---------------------------: | :-----------------------------: | :-------: |
| [Master](https://github.com/OuhscBbmc/pluripotent/tree/master) | [![Build Status](https://travis-ci.org/OuhscBbmc/pluripotent.svg?branch=master)](https://travis-ci.org/OuhscBbmc/pluripotent) | [![Build status](https://ci.appveyor.com/api/projects/status/ie2hgogtuqom092k/branch/master?svg=true)](https://ci.appveyor.com/project/wibeasley/pluripotent/branch/master) | [![Coverage Status](https://coveralls.io/repos/github/OuhscBbmc/pluripotent/badge.svg?branch=master)](https://coveralls.io/github/OuhscBbmc/pluripotent?branch=master) |
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

##### {renv} new package install exercise #####

## Initialize {renv} within your in-class R project
renv::init()

## Install a new R package and use this package in an R script saved within your project directory
#install.packages("TeachingDemos")
library(TeachingDemos)
beyonce <- char2seed("beyonce")
hbd <- char2seed("Happy Birthday To You!")

#install.packages("devtools")
library(devtools)
devtools::install_github("hadley/emo")

## Run renv::status() to make sure your project picked up the package as a dependency
renv::status()

## Open renv.lock file and ctrl+F package name to confirm that new package is missing

## Run renv::snapshot() to record the new packages in your lockfile
renv::snapshot()

## Reopen renv.lock file to confirm that new package has been captured in lockfile

##### ERROR TROUBLSHOOTING #####
## Workflow workaround for error installing new packages after renv::init() activated
renv::init()
#install.packages("X") // renv::install() --> error!
renv::deactivate()
install.packages("X")
renv::activate()
install.packages("")
## TLDR: Only run renv::init() at the end of coding your project (not beginning)



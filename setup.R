# Run once, from this directory: Rscript --vanilla setup.R
# Or open analysis.Rproj in RStudio and run source("setup.R").
args <- commandArgs(trailingOnly = FALSE)
script <- grep("^--file=", args, value = TRUE)
if (length(script)) setwd(dirname(normalizePath(sub("^--file=", "", script[1]))))
stopifnot(file.exists("renv.lock"))
if (getRversion() < "4.5.0" || getRversion() >= "4.6.0") {
  stop("Use R 4.5.x (tested with 4.5.3). The pinned Bioconductor 3.21 environment targets R 4.5.")
}
options(repos = c(CRAN = "https://cloud.r-project.org"), timeout = 600)
dir.create("renv/bootstrap", recursive = TRUE, showWarnings = FALSE)
dir.create("renv/library", recursive = TRUE, showWarnings = FALSE)
.libPaths(c(normalizePath("renv/bootstrap"), .libPaths()))
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", lib = "renv/bootstrap")
}
renv::restore(project = getwd(), library = file.path(getwd(), "renv/library"),
              lockfile = "renv.lock", prompt = FALSE)
message("Dependencies restored. Next: Rscript --vanilla run.R, or source('run.R') in RStudio.")

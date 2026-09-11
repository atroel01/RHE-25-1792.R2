# All scientific analysis lives in analysis.Rmd; this launcher verifies and renders it.
args <- commandArgs(trailingOnly = FALSE)
script <- grep("^--file=", args, value = TRUE)
if (length(script)) setwd(dirname(normalizePath(sub("^--file=", "", script[1]))))
stopifnot(file.exists("analysis.Rmd"), file.exists("renv.lock"))
lib <- Sys.getenv("RF_VALIDATION_LIBRARY", unset = file.path(getwd(), "renv/library"))
if (!dir.exists(lib)) stop("Run setup.R first to install the pinned dependencies.")
.libPaths(c(normalizePath(lib), .Library))
if (!requireNamespace("jsonlite", quietly = TRUE) || !requireNamespace("digest", quietly = TRUE))
  stop("Dependencies missing: run setup.R first.")
lock <- jsonlite::read_json("renv.lock", simplifyVector = FALSE)
if (as.character(getRversion()) != lock$R$Version)
  warning("Tested R version is ", lock$R$Version, "; current version is ", getRversion())
wrong <- vapply(lock$Packages, function(p) {
  !requireNamespace(p$Package, quietly = TRUE) ||
    utils::packageVersion(p$Package) != package_version(p$Version)
}, logical(1))
if (any(wrong)) stop("Missing or different package versions: ",
  paste(names(wrong)[wrong], collapse = ", "), ". Run setup.R.")
if (!rmarkdown::pandoc_available())
  stop("Pandoc was not found. Run source('run.R') inside RStudio, or install Pandoc and put it on PATH.")
rmarkdown::render("analysis.Rmd", envir = new.env(parent = globalenv()), clean = TRUE)
expected <- c("Fig1.png", "Fig2.png", "Fig3.png", "Fig4A.png", "Supplementary1.png",
              "Supplementary2.png", "participant_summary.csv", "run_summary.csv", "session_info.txt")
stopifnot(all(file.exists(file.path("outputs", expected))))
message("Complete: open analysis.html. Figures, tables and diagnostics are in outputs/.")

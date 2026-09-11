# RHE-25-1792.R2

A specific molecular Profiling of Secreted Rheumatoid Factors in Sjögren’s disease patients with lymphoma.

## Reproduce the graphs

Use R **4.5.3** and RStudio. Open `analysis.Rproj` and run:

```r
source("setup.R")  # install dependencies once; requires internet
source("run.R")    # check inputs and regenerate graphs
```

Figures are saved to `outputs/`. `analysis.html` displays the results and code.
Generated files stay local and are excluded from Git.

The notebook uses participant/cohort peptide grouping and strict
mutation filtering. RF units are IU/L.

## Files

| File | Purpose |
|---|---|
| `analysis.Rmd` | Annotated analysis that generates the graphs |
| `setup.R`, `run.R`, `renv.lock` | Install pinned dependencies, verify inputs, and run |
| `data/rf_ighv_peptide_alignment.txt` | Curated peptide alignments; preserve whitespace |
| `data/rf_levels.csv`, `dominant_clones.csv` | Coded RF measurements and clone annotations |
| `data/reference/` | IMGT reference and amino-acid lookups |
| `data/sequences/` | Heavy/light chain and HCDR3 sequences |
| `data/mcsm_ab2/` | Five precomputed affinity scans |

These are downstream analysis inputs. Instrument processing, docking and affinity
prediction are not rerun. Outputs are `Fig1.png`, `Fig2.png`, `Fig3.png`,
`Fig4A.png`, `Supplementary1.png` and `Supplementary2.png`; numbering follows the
supplied script. Figure 4B was a placeholder and is not generated.

The notebook was tested in a fresh R 4.5.3 session on macOS with all 162 locked
package versions. Fresh downloads and other operating systems remain untested.
Setup may require OS build tools. For terminal use, run `Rscript --vanilla setup.R`
then `Rscript --vanilla run.R`; Pandoc must be installed or `RSTUDIO_PANDOC` set.

[Authors](AUTHORS.md) · [Citation](CITATION.cff)

Code and documentation are MIT licensed. Data licensing is pending; this licence
does not cover `data/`.
Third-party reference data retain their own terms, including
[IMGT](https://www.imgt.org/IMGTinformation/). HCDR3 reference labels are preserved
from the supplied script; their bibliography mapping has not been verified.

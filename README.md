# Snakemake workflow: MANx (Microbial Assembler quaNtitative eXploration)

[![Workflow rule graph]([LINK/TO/OUTPUT.svg)]([https://github.com/snakemake/snakemake/blob/main/docs/snakefiles/deployment.rst](https://github.com/snakemake/snakemake/blob/main/docs/snakefiles/deployment.rst))](Snakemake Deployment Best Practices)

[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)

# Workflow summary

## FDA-ARGOS benchmarking dataset
- user can specify desired parameters for subsetting
- downloads NCBI assembly, SRA reads, and metadata for subset (entrez-direct v 21.6, ncbi-datasets-cli v 16.10.2)
- downsamples each set of reads to three different user-defined coverage levels ("low" "med" "high")
- generates sample_inputs.tsv

## Tool combinations:
Snakemake v 8.10.0-0, Python v 3.12 (unless otherwise specified)
### Trimming
- BBtools v 37.62 for decon
- trimmmomatic v 0.39
### Assembly
- spades v 3.15.5
- skesa v 2.5.1

## Downstream assembly QC
### Note: add references for each tool
For downstream assembly QC:
- runs QUAST v 5.2.0 against reference
- runs CheckM v 1.0.1-0 to assess completeness
- runs all-vs-all dnadiff (mummer v 3.23)

## Report
Uses Snakemake reporting to generate an HTML report compiling assembly QC results.

# Usage
```
snakemake --use-conda
snakemake --report report.html
```

# TODO
* add git action pulling token from secrets 
* Review whether this is the CI scheme I want to continue with.
* Add references for various tools used
* When workflow is finished, store rule graph svg and link in first line of this readme

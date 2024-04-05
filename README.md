# Snakemake workflow: MANx (Microbial Assembler quaNtitative eXploration)

[![Workflow rule graph]([LINK/TO/OUTPUT.svg)]([https://github.com/snakemake/snakemake/blob/main/docs/snakefiles/deployment.rst](https://github.com/snakemake/snakemake/blob/main/docs/snakefiles/deployment.rst))](Snakemake Deployment Best Practices)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)

## Workflow summary

# FDA-ARGOS benchmarking dataset
- user specifies desired parameters for subsetting and downloads NCBI assembly, SRA reads, and metadata
- downsamples each set of reads to three different coverage levels ("low" "med" "high")
- generates sample_inputs.tsv

# A Snakemake workflow for benchmarking:
- two different read trimming schemes
- three different short-read assemblers

# Downstream assembly QC
# Note: add references for each tool
For downstream assembly QC:
- runs QUAST against reference
- runs CheckM to assess completeness
- runs all-vs-all dnaDiff

# Report
Uses Snakemake reporting to generate an HTML report compiling assembly QC results.


## Usage


# TODO
* add git action pulling token from secrets 
* Review whether this is the CI scheme I want to continue with.
* Add references for various tools used

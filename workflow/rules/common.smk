#!/usr/bin/env python3
pipeline = "MAnx"
"""
Common.smk containing one-liner input functions, to make the linter happy.
@author: Mary Godec
Date: 11 april 2024
"""

import pandas as pd

#### samples ####
samplefile = "config/samples.tsv"
SAMPLES = pd.read_csv(samplefile).set_index(["sample", "species"], drop=False)
ECOLI_SAMS = SAMPLES.loc[SAMPLES["species"]=="Ecoli"]

def get_read_paths(wildcards):
    """ comment string """
    fwpath = SAMPLES.loc[(wildcards.sample, wildcards.species), ['R1']].dropna().format(wildcards=wildcards)
    rvpath = SAMPLES.loc[(wildcards.sample, wildcards.species), ['R2']].dropna().format(wildcards=wildcards)
    d = {"FW": fwpath, "RV": rvpath}
    return d
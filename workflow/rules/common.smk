import pandas as pd

#### samples ####
SAMPLES = pd.read_csv(config["samples"]).set_index(["sample", "species"], drop=False)
ECOLI_SAMS = SAMPLES.loc[SAMPLES["species"]=="Ecoli"]

def get_species_samples(wildcards):
    subs = SAMPLES.loc[SAMPLES["species"]==wildcards.species]
    return subs["sample"]

def get_read_paths(wildcards):
    return {"FW": SAMPLES.loc[(wildcards.sample, wildcards.species), ['R1']].dropna(), "RV": SAMPLES.loc[(wildcards.sample, wildcards.species), ['R2']].dropna()}
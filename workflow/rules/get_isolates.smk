

rule get_sra:
    output:
        "resouces/sra/{accession}_1.fastq",
        "resources/sra/{accession}_2.fastq",
    log:
        "logs/get-sra/{accession}.log",
    wrapper:
        "v3.5.3/bio/sra-tools/fasterq-dump"


rule downsample_sra:
    output:
        
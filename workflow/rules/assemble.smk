rule spades:
spades.py -o $SAMOUT -1 $FW -2 $RV -t $nrCores

rule SKESA:
    input:
        FW = expand("trimmed/{d}/{trimcond}/{sample}_1.trimmed.fastq.gz"),
        RV = expand("trimmed/{d}/{trimcond}/{sample}_2.trimmed.fastq.gz"),
expand("assembly/{d}/{trimcond}/SKESA/{sample}.fasta")

skesa --reads '$FW','$RV' --vector_percent 1 --cores $nrCores > $OUTFA
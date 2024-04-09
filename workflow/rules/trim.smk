#rule BBdecon:
#    output:
#        FOUT = "trimmed/{d}/BBdecon/{sample}_1.trimmed.fastq.gz",
#        ROUT = "trimmed/{d}/BBdecon/{sample}_2.trimmed.fastq.gz"
#    input: 
##        FW="reads/{d}/{sample}_1.fastq",
#        RV="reads/{d}/{sample}_2.fastq"
#    params:
#        numThreads = 25
#        ??? define in config
#    shell:
#        "BBduk {input.fq1} {input.fq2} {output.fwout}"
#        'bbduk.sh -Xmx10g t={params.numThreads} in1={input.FW} in2={input.RV} out1={output.FOUT} out2={output.ROUT} ref=adapters,phix ktrim=r k=31 mink=11 hdist=1 tpe tbo'

rule Trimmomatic:
    output:
        FOUT = "trimmed/{d}/trimmomatic/{sp}/{sample}_1.trimmed.fastq.gz",
        ROUT = "trimmed/{d}/trimmomatic/{sp}/{sample}_2.trimmed.fastq.gz",
    input:
        FW = "reads/{d}/{sp}/{sample}_1.fastq.gz",
        RV = "reads/{d}/{sp}/{sample}_2.fastq.gz",
    params:
        numThreads = 25,
    container:
        config["singularity_trim"]
    shell: "TrimmomaticPE -threads {params.numThreads} {input.FW} {input.RV} {output.FOUT} '/dev/null' {output.ROUT} '/dev/null' HEADCROP:2 ILLUMINACLIP:'/usr/share/trimmomatic/TruSeq3-PE-2.fa':2:20:12:1:True SLIDINGWINDOW:3:22 MINLEN:36 CROP:9999 TOPHRED33"
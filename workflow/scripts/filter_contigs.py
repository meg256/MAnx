#!/usr/bin/env python3
"""
Modified version of full filter script. This one is specific for skesa formatting.
Author: Mary Godec, 3 april 2024, modified 10 april 2024
"""

import argparse
import re

def wanted(contig, seq, mincov, minlen):
    # take in contig; get cov and len info in different ways depending on assembler source
    # return True if header passes the criteria
    contname=""
    length=0
    kmers=0
    cov=0

    #example skesa header ">Contig_9_1662.38"
    #sometimes skesa adds an note ">Contig_2_188.92_Circ [topology=circular]"
    s, contname, cov = contig.split("_")[0:3]
    length = len(seq)
    
    if int(float(cov)) > mincov and int(length) > minlen:
        return True
    else:
        return False

    
def fasta_to_dict(infasta):
    # I think read() "slurps" file or reads it all in at once, but apparently still faster than SeqIO parsing
    fasta = open(infasta)
    sequences = fasta.read()
    sequences = re.split("^>", sequences, flags=re.MULTILINE) # Only splits string at the start of a line.
    fasta.close()
    #the first in this list will be blank, so delete it
    del sequences[0]
    #read in dict of header:seq
    fastadict={}
    for fasta in sequences:
        header, sequence = fasta.split("\n", 1) # Split each fasta into header and sequence.
        header = ">" + header + "\n" # Replace ">" lost in ">" split, Replace "\n" lost in split directly above.
        sequence = sequence.replace("\n","") # Take line breaks out of sequence.
        fastadict[header]=sequence

    return fastadict


def main(input_fasta, output_fasta, min_cov, min_len):
    """
    Read a .fasta file and filter the contigs on minimal coverage and minimal length.
    Output a .fasta file with the contigs that passed the filters.
    """
    fdict = fasta_to_dict(input_fasta)
    wanteddict = {k: v for k, v in fdict.items() if wanted(k, v, min_cov, min_len)}

    with open(output_fasta, 'w') as out_file:
        for k,v in wanteddict.items():
            out_file.write(k + "\n" + v + "\n")

    return None
  
# %%   If-Main
if __name__ == '__main__':   # pragma: no cover
    parser = argparse.ArgumentParser(description="Filter assembly fasta to remove contigs below minimum length and coverage thresholds.")
    parser.add_argument('-i', '--input-fasta', dest='input_fasta', required=True,
                        help='Location of .fasta file as outputted by ABySS')
    parser.add_argument('-o', '--output-fasta', dest='output_fasta', required=True,
                        help='Location of filtered .fasta file')
    parser.add_argument('-c', '--min-cov', dest='min_cov', type=int, default=20, help='Minimal coverage [default: 20]')
    parser.add_argument('-l', '--min-len', dest='min_len', type=int, default=1000, help='Minimal contig size [default: 1000]')

    args = parser.parse_args()
    
    if args.min_cov < 0 or args.min_len < 0:
        raise ValueError(f'Filter values must be positive! min_cov: {args.min_cov}, min_len: {args.min_len}')
    else:
        main(args.input_fasta, args.output_fasta, args.min_cov, args.min_len)
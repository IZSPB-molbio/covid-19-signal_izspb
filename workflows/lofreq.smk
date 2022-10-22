#!/usr/bin env python

import os
import glob
# bam files:
# results/*/COVID-*/core/COVID-*_viral_reference.mapping.primertrimmed.sorted.clip.bam
# cmd line:
# lofreq call -f MN908947.3.fasta -o vars.vcf COVID-7341_viral_reference.mapping.primertrimmed.sorted.clip.bam 

sample_folders = glob.glob("results/*/COVID-*")
#bam_files = glob.glob("results/*/COVID-*/core/COVID-*_viral_reference.mapping.primertrimmed.sorted.clip.bam")

samples = []

for sample_folder in sample_folders:
    sample = sample_folder.split("/")[-1].split("-")[-1]
    sample.append(sample)
    
rule all:
    input: expand("results/lofreq/outputs/COVID-{sample}_lofreq.vcf", sample=samples) 

rule lofreq:
    input:
        "results/lofreq/inputs/COVID-{sample}_viral_reference.mapping.primertrimmed.sorted.clip.bam"
    output:
        "results/lofreq/outputs/COVID-{sample}_lofreq.vcf"

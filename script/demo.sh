#!/bin/bash
tabix -f -p vcf demo/demo.vcf.gz 
tabix -f -p vcf demo/popu.vcf.gz 
mkdir -p demo/output
sh script/step1_beagle4.0_phasing_beta.sh demo/demo.vcf.gz demo/popu.vcf.gz demo/output/demo.step1
sh script/step2_amn_NIPD_analysis_0.02.sh demo/output/demo.step1.phased.vcf.gz demo/demo.vcf.gz chr11:5248200 chr11:5247992 demo/output/demo.step2
perl script/step3_noninvasive_hap_verify.pl demo/output/demo.step2.parent.hap demo/demo.vcf.gz chr11:5248200 chr11:5247992 demo/output/demo.step3
Rscript script/step4_HMM_dbi_pat_OR_0.02.R demo/output/demo.step2
Rscript script/step4_HMM_dbi_mat_OR.v2.R demo/output/demo.step2



pipelinePath=".."

rm -rf snp laser jobfiles  seekin  run.yaml

# Generate the job files in the directory "./jobfiles" 

/mnt/projects/rpd/apps/miniconda3/bin/python  $pipelinePath/lib/GetConf.py  -c test.conf     -o run.yaml

snakemake --snakefile null --unlock
# Run the piepline 

snakemake -s $pipelinePath/Snakefile  --jobs 300 --rerun-incomplete --timestamp --printshellcmds --stats logs/snakemake.stats --configfile run.yaml --latency-wait 60 --cluster-config cluster.GIS.yaml --drmaa " -pe OpenMP {threads} -l mem_free={cluster.mem} -l h_rt={cluster.time} -cwd -v PATH -e logs -o logs -w n" --jobname "SEEKIN.slave.{rulename}.{jobid}.sh" --config ANALYSIS_ID=2017-08-11T00-07-13.131971 >> logs/snakemake.log 2>&1

# You can also run step varCall, laser separately using the "target"  option in snakemake 
# For calling variants only, please add option "varCall" to the above pipeline 
# For running laser only, please add option "laser" to the above pipeline

Relatedness_true="Study.array.kin"
perl $pipelinePath/scripts/fmt.pl   $Relatedness_true  ./seekin/seekin.kin   ./seekin/seekin  SEEKIN  admix

// Define a simple workflow
workflow {
    fastq1 = file('s3://dublin-nextflowbucket/dragen_fastq_example/NIST7035_TAAGGCGA_L001_R1_001_trimmed.fastq.gz')
    fastq2 = file('s3://dublin-nextflowbucket/dragen_fastq_example/NIST7035_TAAGGCGA_L001_R2_001_trimmed.fastq.gz')
    
    // Call the simpleJob process
    simpleDragen(fastq1,fastq2)
    // Optionally, you can define other processes or steps in your workflow here
}

// Define the process
process simpleDragen {
    container 'sedlawrence/python_container:aws'
    input:
    file fastq1
    file fastq2
    script:
    """
    dragen --output-directory /staging/ --fastq-file1 $fastq1 --fastq-file2 $fastq2 \
    --output-file-prefix sample --ref-dir /staging/hg19 --enable-variant-caller true \ 
    --enable-map-align true --vc-sample-name RGSM --output-format BAM --enable-map-align-output true
    """
}

nextflow.enable.dsl = 2

params.mhcquant_outdir = null
params.outdir          = '.'

workflow {

    if (!params.mhcquant_outdir) {
        error "Required param: --mhcquant_outdir <path> (directory containing mhcquant per-sample *.tsv files)"
    }

    channel
        .fromPath("${params.mhcquant_outdir}/*.tsv", checkIfExists: true)
        .map { tsv ->
            def sample = tsv.baseName
            "${sample},peptide,${tsv}"
        }
        .collectFile(
            name:     'samplesheet.csv',
            storeDir: params.outdir,
            seed:     'sample,seq_type,tsv',
            newLine:  true,
            sort:     true,
        )
}

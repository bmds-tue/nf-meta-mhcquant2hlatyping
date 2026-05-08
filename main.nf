nextflow.enable.dsl = 2

workflow {

    if (!params.mhcquant_outdir) {
        error "Required param: --mhcquant_outdir <path> (directory containing mhcquant per-sample *.tsv files)"
    }

    channel
        .fromPath("${params.mhcquant_outdir}/${params.glob}", checkIfExists: true)
        .map { tsv ->
            def sample = tsv.baseName
            "${sample},${params.seq_type},${tsv}"
        }
        .collectFile(
            name:     'samplesheet.csv',
            storeDir: params.outdir,
            seed:     'sample,seq_type,tsv',
            newLine:  true,
            sort:     true,
        )
        .view { f -> "Wrote ${f}" }
}

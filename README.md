# nf-meta-mhcquant2hlatyping

Minimal Nextflow connector that converts an [nf-core/mhcquant](https://github.com/nf-core/mhcquant) results directory into a samplesheet consumable by [nf-core/hlatyping](https://github.com/nf-core/hlatyping) (`--tools immunotype`).

## Usage

```bash
nextflow run https://github.com/bmds-tue/nf-meta-mhcquant2hlatyping \
  --mhcquant_outdir <path/to/mhcquant/results> \
  --outdir         <out>
```

## Parameters

| Param | Default | Description |
|---|---|---|
| `mhcquant_outdir` | (required) | Directory containing per-sample mhcquant `*.tsv` peptide tables. |
| `outdir` | `.` | Where `samplesheet.csv` is written. |

## Output

`${outdir}/samplesheet.csv` with columns:

| Column | Source |
|---|---|
| `sample` | Filename stem of each TSV (e.g. `PBMC007_B.tsv` → `PBMC007_B`). Matches mhcquant's `${Sample}_${Condition}` naming. |
| `seq_type` | Hardcoded to `peptide` (required by hlatyping `--tools immunotype`). |
| `tsv` | Absolute path to the discovered TSV. |


## Test

```bash
nf-test test test/main.nf.test
```

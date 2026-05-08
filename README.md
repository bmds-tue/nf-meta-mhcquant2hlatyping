# nf-meta-mhcquant2hlatyping

Minimal Nextflow connector that converts an [nf-core/mhcquant](https://github.com/nf-core/mhcquant) results directory into a samplesheet consumable by [nf-core/hlatyping](https://github.com/nf-core/hlatyping) (`dev` branch, `--tools immunotype`).

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
| `glob` | `*.tsv` | Glob applied inside `mhcquant_outdir`. Override if mhcquant publishes into a subdir. |
| `seq_type` | `peptide` | Value emitted in the `seq_type` column. Required to be `peptide` for hlatyping immunotype. |

## Output

`${outdir}/samplesheet.csv` with columns:

| Column | Source |
|---|---|
| `sample` | Filename stem of each TSV (e.g. `PBMC007_B.tsv` → `PBMC007_B`). Matches mhcquant's `${Sample}_${Condition}` naming. |
| `seq_type` | Value of `params.seq_type` (default `peptide`). |
| `tsv` | Absolute path to the discovered TSV. |

The output is shaped to match nf-core/hlatyping's `assets/schema_input.json` on the `dev` branch when `--tools immunotype` is used. hlatyping's `--peptide_col_name` defaults to `sequence`, which is the column mhcquant publishes — no further remapping is needed.

## Test

```bash
nf-test test test/main.nf.test
```

# 💎 obsidian-scripts

This repo is a library of scripts and code snippets that help me organize my Obsidian vault better, faster, and cleaner.

![Obsidian](/aes/obsidian-unsplash.jpg)

## 🤖 Automated Creation of Notes

### 🧬 Marker Genes

Briefly: R script that transforms a TSV/CSV file into markdown notes with YAML metadata for automated integration into Obsidian. The script is dedicated to the creation of notes on marker genes -one note per gene- following a pre-selected note template. The input file follows a specific table format that (currently) works best for the organization of marker genes. The created markdown is outputed directly inside the Obsidian vault. See below for more details on the input format and markdown note structure.

#### Input File

The R script assumes specific YAML metadata entries and, by extension, specific columns in the input file. Following the note template that is currently used in my Obsidian vault, an example for a gene entry in the input file is shown below:

| name	| aliases	| mm-gene	|	hs-gene	|	common-name	|	celltype	|	subtype	|	source	|	notes	|	tumor	|	main-body	|	update	|
|---| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Mki67 | KI-67, Ki-67 | Mki67	|		|		| Monocytes	|	Proliferating	|	[Molgora (2020)](https://doi.org/10.1016/j.cell.2020.07.013)	|	[[Molgora-Cell-2020]]	 |  |	 |	TRUE	|
| Mki67 | KI-67, Ki-67 | Mki67	|		|	  |	Macrophages	|	Proliferating	|	[Molgora (2020)](https://doi.org/10.1016/j.cell.2020.07.013)	|	[[Molgora-Cell-2020]]	|  |	|	TRUE	|
| Mki67 | KI-67, Ki-67 | Mki67	|		| 	|	Neutrophils	|	Neutrophils	|	[PanglaoDB](https://panglaodb.se/search.html?query=%22MKI67%22&species=2&tumor=0&nonadult=0)|	| | |	TRUE	|

<details>
<summary>In more detail:</summary>
  
| Input file column | Details |
| --- | --- |
| name | name of Obsidian note |
| aliases | alternative names to facilitate connections between Obsidian notes |
| mm-gene | Mus musculus gene name |
| hs-gene | Homo sapiens gene name |
| common-name | other, commonly used gene names |
| celltype | cell type classification |
| subtype | cell type sub-type classification |
| source | markdown-format link leading to the publication or source that reported the celltype and subtype classification |
| notes | Obsidian link to related Obsidian note, e.g. link to the notes on corresponding paper |
| tumor | related tumor type |
| main-body | text to be written in the note's main body |
| update | binary, whether to update the note inside the obsidian vault; if TRUE, existing note will be overwritten |
  
</details>

Entries with the same name are collapsed under the same note.

#### Output Note Structure

The marker note template follows the following structure for its metadata entries/ header:

```
---
aliases: []
mm-gene:
hs-gene:
common-name:
celltype:
subtype-source-notes: 
- ";[](https://doi.org/)"
tumor:
---

Links: [[000 Vault TOC]], [[030 Gene Cards]]
#marker

---
```

The `Links` are Obsidian links to upper-level MOC notes (used when the Obsidian vault follows the Map of Contents structure, [nice link here](https://forum.obsidian.md/t/a-case-for-mocs/2418)).

#### Running the Script

The [script](src/Obsidian.Table_to_Marker_Note.R) takes two arguments, the path to the input TSV/CSV file, and the output directory (or sub-directory inside the Obsidian vault).

```
Rscript Obsidian.Table_to_Marker_Note.R --INPUTFILE "ImmuneMarkersLeda.tsv"
                                        --OUTPUTDIR "/home/leda/ObsidianVault/030\ Gene\ Cards"
```

## 🥐 Code Snippets

### 📑 Dataview Queries

#### 1. Dataview query for organizing gene markers into columns based on the celltype/sub-type classification and the respective source

```
`` `dataview
TABLE WITHOUT ID
	split(string(subtype-source-notes), ";")[0] AS Sub-type,
	rows.file.link AS Markers,
	split(string(subtype-source-notes), ";")[1] AS Source,
	split(string(subtype-source-notes), ";")[2] AS Notes
FROM #marker
WHERE contains(celltype, "Macrophages") = true
FLATTEN subtype-source-notes
GROUP BY subtype-source-notes
SORT subtype-source-notes ASC
`` `
```

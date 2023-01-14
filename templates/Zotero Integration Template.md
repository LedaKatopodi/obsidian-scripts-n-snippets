Links: [[000 Vault TOC]], [[050 Papers]]

# {{title}}

## Bibliography Information

>[!metadata]
**Title**:: {{title}}
**Author**:: 
**Author List**:: {%- for creator in creators %} {{creator.firstName}} {{creator.lastName}}, {%- endfor %}
<br>**Citekey**:: {{citekey}}<br>{%- if DOI %}**DOI**:: {{DOI}} {%- endif %}
**DatePublished**:: {{date | format("YYYY/MM/DD")}}
**DateRead**:: {{dateAdded | format("YYYY/MM/DD")}}
{%- if itemType == "journalArticle" %}
**Journal**:: _{{publicationTitle}}_{%- endif %}
**Tags**::


> [!Cite]  
> {{bibliography}}

---
## Summary

{% if abstractNote %}
>[!abstract]
> {{abstractNote}}
{% endif %}

>[!contribution]
**Contribution**::

---

## Notes from PDF Annotations

{%- macro colorValueToName(color) -%}
	{%- switch color -%}
		{%- case "#ffd400" -%} 
			✒️ Background
		{%- case "#ff6666" -%} 
			❓ Disagree
		{%- case "#5fb236" -%} 
			🧪 Analysis 
		{%- case "#2ea8e5" -%} 
			⭐ Important
		{%- case "#a28ae5" -%} 
			📑 Nice Quote
		{%- endswitch -%} 
{%- endmacro -%} 

{%- macro calloutHeader(type) -%} 
	{%- switch type -%} 
		{%- case "highlight" -%} 
			Highlights 
		{%- default -%} 
			Notes 
	{%- endswitch -%} 
{%- endmacro %} 

{% persist "annotations" %} 
{% set annots = annotations | filterby("date", "dateafter", lastImportDate) -%} 
{% if annots.length > 0 %} 
> Imported on {{importDate | format("YYYY/MM/DD h:mm a")}} 

{% for type, annots in annots | groupby("type") -%} 
### {{calloutHeader(type)}} 
{% for annot in annots -%} 
**_{{colorValueToName(annot.color)}}_** 
{%- if annot.annotatedText %} | {{annot.annotatedText | nl2br}} 
{%- endif -%} 

{%- if annot.ocrText %} > {{annot.ocrText}} 
{%- endif %} 

{%- if annot.comment %} > >> {{annot.comment | nl2br}} 
{%- endif %}

{% endfor -%} 
{% endfor -%} 
{% endif %} 
{% endpersist %}

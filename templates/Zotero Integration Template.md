Links: [[000 Vault TOC]], [[060 Papers]]

# {{title}}

## Bibliography Information

>[!metadata]
**Title**:: {{title}}
**Author**:: 
**Author List**:: {%- for creator in creators %} {{creator.firstName}} {{creator.lastName}}, {%- endfor %}
<br>**Citekey**:: {{citekey}}
{%- if DOI %}**DOI**:: {{DOI}} {%- endif %}
**DatePublished**:: {{date | format("YYYY/MM/DD")}}
**DateRead**:: {{dateAdded | format("YYYY/MM/DD")}}
{%- if itemType == "journalArticle" %}**Journal**:: _{{publicationTitle}}_{%- endif %}
**Tags**::


> [!Cite]  
> {{bibliography}}

---
## Summary

>[!abstract]
> {% if abstractNote %}
> {{abstractNote}}
> {% endif %}

>[!contribution]
Contribution::

---

## Notes from PDF Annotations

{%- macro colorValueToName(color) -%}
	{%- switch color -%}
		{%- case "#ffd400" -%} 
			Background information
		{%- case "#ff6666" -%} 
			Disagree or Questionable points
		{%- case "#5fb236" -%} 
			Interesting points 
		{%- case "#2ea8e5" -%} 
			Key conclusions
		{%- case "#a28ae5" -%} 
			Nice wording
		{%- endswitch -%} 
{%- endmacro -%} 

{%- macro calloutHeader(type) -%} 
	{%- switch type -%} 
		{%- case "highlight" -%} 
			Highlight 
		{%- default -%} 
			Note 
	{%- endswitch -%} 
{%- endmacro %} 

{% persist "annotations" %} 
{% set annots = annotations | filterby("date", "dateafter", lastImportDate) -%} 
{% if annots.length > 0 %} 
> Imported on {{importDate | format("YYYY-MM-DD h:mm a")}} 

{% for color, annots in annots | groupby("color") -%} 
### {{colorValueToName(color)}} 
{% for annot in annots -%} 
**_{{calloutHeader(annot.type)}}_** 
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

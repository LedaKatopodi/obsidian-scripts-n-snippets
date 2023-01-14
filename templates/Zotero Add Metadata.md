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

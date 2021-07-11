## Installation instructions for:
[Hkube](https://hkube.io/learn/install/)

## Stable releases
{% for version in site.stableVersions %}
### {{version}}
{% for chartmap in site.data.index.entries %}
{% if site.stableCharts contains chartmap[0] %}
|Version | Date | App. version|
|---------|----------|---------------------|
{%- assign sortedcharts = chartmap[1] | where_exp:"item","item.version contains version" | sort: 'created' | reverse -%}
{%- for item in sortedcharts %}
|[{{ item.version }}]({{ item.urls[0] }}) | {{ item.created | date_to_long_string }} | {{ item.appVersion }}|
{%- endfor %}
{%- endif %}
{% endfor %}
{% endfor %}


<!-- {% for chartmap in site.data.index.entries %}
  {% if site.stableCharts contains chartmap[0] %}
### {{ chartmap[0] }}

| Version | Date | App. version |
|---------|------|---------------------|
    {%- assign sortedcharts = chartmap[1] | sort: 'created' | reverse -%}
    {%- for chart in sortedcharts -%}
| [{{ chart.version }}]({{ chart.urls[0] }}) | {{ chart.created | date_to_long_string }} | {{ chart.appVersion }} |
    {%- endfor %}
  {%- endif %}
{% endfor %}

 -->

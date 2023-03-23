{#
    This macro extracts string arrays (if they exist) for a given geographic
    targeting level. Expects a json column of geo information called "geos".
#}
{% macro extract_snapchat_geo(geo_value) -%}
{{ json_extract_string_array(unnested_column_value("geos"), [geo_value], [geo_value]) }}
{%- endmacro %}

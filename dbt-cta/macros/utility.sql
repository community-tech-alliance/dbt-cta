{% macro latest_partition(project, dataset, table_name) -%}
  
  {% call statement('get_max_partition', fetch_result=True) -%}
    SELECT MAX(PARSE_TIMESTAMP("%Y%m%d",partition_id)) as max_partition_date
    FROM {{ '`' ~ project ~ '.' ~ dataset ~ '.INFORMATION_SCHEMA.PARTITIONS`' }}
    WHERE table_name = '{{ table_name }}'
  {%- endcall %}

  {% if execute %}
    {% set max_existing_partition = load_result('get_max_partition').table.columns['max_partition_date'].values()[0] %}
    {{ return(max_existing_partition) }}
  {% else %}
    {{ return(false) }}
  {% endif %}
  
{%- endmacro %}
-- see
-- https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-custom-schemas/#an-alternative-pattern-for-generating-schema-names
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ generate_schema_name_for_env(custom_schema_name, node) }}
    {%- else -%}
        {{ custom_schema_name }}
    {%- endif -%}
{%- endmacro %}
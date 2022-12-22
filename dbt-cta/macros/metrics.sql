{% macro millis_to_dollars(column) -%}
  safe_divide({{ column }}, 1000000)
{%- endmacro %}

{% macro string_millis_to_dollars(column) -%}
    {{ 'safe_cast('~millis_to_dollars('safe_cast('~column~' as numeric)')~' as string)' }}
{%- endmacro %}

{% macro ad_stats_cpm(cost, impressions) -%}
  {{ millis_to_dollars('safe_divide( '~cost~', safe_divide('~impressions~', 1000))')}}
{%- endmacro %}

{% macro ad_stats_ctr(clicks, impressions) -%}
  safe_divide({{ clicks }}, {{ impressions }})
{%- endmacro %}
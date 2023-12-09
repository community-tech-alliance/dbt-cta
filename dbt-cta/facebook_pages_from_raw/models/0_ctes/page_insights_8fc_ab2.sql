{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
) }}

{% set raw_source_name = var('cta_dataset_id') + "_raw__stream_page" %}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_insights_8fc_ab1') }}
select
    cast(period as {{ dbt_utils.type_string() }}) as period,
    values,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_insights_8fc_ab1') }}
-- page_insights
where 1 = 1


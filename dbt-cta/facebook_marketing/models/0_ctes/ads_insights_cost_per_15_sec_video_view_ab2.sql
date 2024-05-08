{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ads_insights_cost_per_15_sec_video_view_ab1') }}
select
    _airbyte_ads_insights_hashid,
    cast(value as {{ dbt_utils.type_float() }}) as value,
    cast(_1d_view as {{ dbt_utils.type_float() }}) as _1d_view,
    cast(_7d_view as {{ dbt_utils.type_float() }}) as _7d_view,
    cast(_1d_click as {{ dbt_utils.type_float() }}) as _1d_click,
    cast(_28d_view as {{ dbt_utils.type_float() }}) as _28d_view,
    cast(_7d_click as {{ dbt_utils.type_float() }}) as _7d_click,
    cast(_28d_click as {{ dbt_utils.type_float() }}) as _28d_click,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(action_target_id as {{ dbt_utils.type_string() }}) as action_target_id,
    cast(action_destination as {{ dbt_utils.type_string() }}) as action_destination,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ads_insights_cost_per_15_sec_video_view_ab1') }}
-- cost_per_15_sec_video_view at ads_insights/cost_per_15_sec_video_view
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}


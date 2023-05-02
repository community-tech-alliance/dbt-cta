{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaign_topline_setting_items_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(item_id as {{ dbt_utils.type_string() }}) as item_id,
    {{ cast_to_boolean('imported') }} as imported,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(item_type as {{ dbt_utils.type_string() }}) as item_type,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(targetable_id as {{ dbt_utils.type_bigint() }}) as targetable_id,
    cast(targetable_type as {{ dbt_utils.type_string() }}) as targetable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaign_topline_setting_items_ab1') }}
-- campaign_topline_setting_items
where 1 = 1


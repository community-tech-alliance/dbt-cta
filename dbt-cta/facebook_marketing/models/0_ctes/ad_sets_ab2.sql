{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ad_sets_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    adlabels,
    cast(bid_info as {{ type_json() }}) as bid_info,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_with_timezone() }}) as end_time,
    cast(targeting as {{ type_json() }}) as targeting,
    cast(account_id as {{ dbt_utils.type_string() }}) as account_id,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_with_timezone() }}) as start_time,
    cast(campaign_id as {{ dbt_utils.type_string() }}) as campaign_id,
    cast({{ empty_string_to_null('created_time') }} as {{ type_timestamp_with_timezone() }}) as created_time,
    cast(daily_budget as {{ dbt_utils.type_float() }}) as daily_budget,
    cast({{ empty_string_to_null('updated_time') }} as {{ type_timestamp_with_timezone() }}) as updated_time,
    cast(lifetime_budget as {{ dbt_utils.type_float() }}) as lifetime_budget,
    cast(promoted_object as {{ type_json() }}) as promoted_object,
    cast(budget_remaining as {{ dbt_utils.type_float() }}) as budget_remaining,
    cast(effective_status as {{ dbt_utils.type_string() }}) as effective_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ad_sets_ab1') }}
-- ad_sets
where 1 = 1

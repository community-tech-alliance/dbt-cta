{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adsquads_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    {{ cast_to_boolean('auto_bid') }} as auto_bid,
    cast(end_time as {{ dbt_utils.type_string() }}) as end_time,
    cast(placement as {{ dbt_utils.type_string() }}) as placement,
    cast(targeting as {{ type_json() }}) as targeting,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    {{ cast_to_boolean('target_bid') }} as target_bid,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_string() }}) as campaign_id,
    cast(pacing_type as {{ dbt_utils.type_string() }}) as pacing_type,
    cast(bid_strategy as {{ dbt_utils.type_string() }}) as bid_strategy,
    cast(billing_event as {{ dbt_utils.type_string() }}) as billing_event,
    cast(child_ad_type as {{ dbt_utils.type_string() }}) as child_ad_type,
    cast(creation_state as {{ dbt_utils.type_string() }}) as creation_state,
    delivery_status,
    cast(optimization_goal as {{ dbt_utils.type_string() }}) as optimization_goal,
    cast(daily_budget_micro as {{ dbt_utils.type_bigint() }}) as daily_budget_micro,
    cast(delivery_constraint as {{ dbt_utils.type_string() }}) as delivery_constraint,
    cast(forced_view_setting as {{ dbt_utils.type_string() }}) as forced_view_setting,
    cast(lifetime_budget_micro as {{ dbt_utils.type_bigint() }}) as lifetime_budget_micro,
    cast(skadnetwork_properties as {{ type_json() }}) as skadnetwork_properties,
    cast(targeting_reach_status as {{ dbt_utils.type_string() }}) as targeting_reach_status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_ab1') }}
-- adsquads
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}


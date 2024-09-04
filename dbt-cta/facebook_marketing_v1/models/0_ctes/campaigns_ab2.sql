{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    adlabels,
    cast(objective as {{ dbt_utils.type_string() }}) as objective,
    cast(spend_cap as {{ dbt_utils.type_float() }}) as spend_cap,
    cast({{ empty_string_to_null('stop_time') }} as {{ type_timestamp_with_timezone() }}) as stop_time,
    cast(account_id as {{ dbt_utils.type_string() }}) as account_id,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_with_timezone() }}) as start_time,
    cast(buying_type as {{ dbt_utils.type_string() }}) as buying_type,
    issues_info,
    cast(bid_strategy as {{ dbt_utils.type_string() }}) as bid_strategy,
    cast({{ empty_string_to_null('created_time') }} as {{ type_timestamp_with_timezone() }}) as created_time,
    cast(daily_budget as {{ dbt_utils.type_float() }}) as daily_budget,
    cast({{ empty_string_to_null('updated_time') }} as {{ type_timestamp_with_timezone() }}) as updated_time,
    cast(lifetime_budget as {{ dbt_utils.type_float() }}) as lifetime_budget,
    cast(budget_remaining as {{ dbt_utils.type_float() }}) as budget_remaining,
    cast(effective_status as {{ dbt_utils.type_string() }}) as effective_status,
    cast(source_campaign_id as {{ dbt_utils.type_float() }}) as source_campaign_id,
    cast(special_ad_category as {{ dbt_utils.type_string() }}) as special_ad_category,
    cast(smart_promotion_type as {{ dbt_utils.type_string() }}) as smart_promotion_type,
    {{ cast_to_boolean('budget_rebalance_flag') }} as budget_rebalance_flag,
    special_ad_category_country,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
-- campaigns
where 1 = 1

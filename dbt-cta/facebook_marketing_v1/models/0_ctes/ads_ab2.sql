{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ads_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    adlabels,
    cast(adset_id as {{ dbt_utils.type_string() }}) as adset_id,
    cast(bid_info as {{ type_json() }}) as bid_info,
    cast(bid_type as {{ dbt_utils.type_string() }}) as bid_type,
    cast(creative as {{ type_json() }}) as creative,
    cast(targeting as {{ type_json() }}) as targeting,
    cast(account_id as {{ dbt_utils.type_string() }}) as account_id,
    cast(bid_amount as {{ dbt_utils.type_bigint() }}) as bid_amount,
    cast(campaign_id as {{ dbt_utils.type_string() }}) as campaign_id,
    cast({{ empty_string_to_null('created_time') }} as {{ type_timestamp_with_timezone() }}) as created_time,
    cast(source_ad_id as {{ dbt_utils.type_string() }}) as source_ad_id,
    cast({{ empty_string_to_null('updated_time') }} as {{ type_timestamp_with_timezone() }}) as updated_time,
    tracking_specs,
    recommendations,
    conversion_specs,
    cast(effective_status as {{ dbt_utils.type_string() }}) as effective_status,
    cast(last_updated_by_app_id as {{ dbt_utils.type_string() }}) as last_updated_by_app_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ads_ab1') }}
-- ads
where 1 = 1


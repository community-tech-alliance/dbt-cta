{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(icon as {{ type_json() }}) as icon,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(channel as {{ dbt_utils.type_string() }}) as channel,
    cast(cta_text as {{ dbt_utils.type_string() }}) as cta_text,
    cast(brandname as {{ dbt_utils.type_string() }}) as brandname,
    cast(click_url as {{ dbt_utils.type_string() }}) as click_url,
    creatives,
    cast(input_data as {{ type_json() }}) as input_data,
    cast(audit_status as {{ dbt_utils.type_string() }}) as audit_status,
    vast_trackers,
    api_frameworks,
    imp_tracker_urls,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_ab1') }}
-- native_ads
where 1 = 1


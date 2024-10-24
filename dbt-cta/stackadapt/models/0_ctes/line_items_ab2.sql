{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('line_items_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(budget as {{ dbt_utils.type_float() }}) as budget,
    cast(end_date as {{ dbt_utils.type_string() }}) as end_date,
    cast(daily_cap as {{ dbt_utils.type_float() }}) as daily_cap,
    cast(start_date as {{ dbt_utils.type_string() }}) as start_date,
    safe_cast(pace_evenly as boolean) as pace_evenly,
    cast(revenue_type as {{ dbt_utils.type_string() }}) as revenue_type,
    cast(advertiser_id as {{ dbt_utils.type_bigint() }}) as advertiser_id,
    cast(revenue_value as {{ dbt_utils.type_float() }}) as revenue_value,
    all_campaign_ids,
    cast(black_list_options as {{ dbt_utils.type_string() }}) as black_list_options,
    cast(purchase_order_number as {{ dbt_utils.type_string() }}) as purchase_order_number,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('line_items_ab1') }}
-- line_items
where 1 = 1

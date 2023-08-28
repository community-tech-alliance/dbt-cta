{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_line_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['budget'], ['budget']) }} as budget,
    {{ json_extract_scalar('_airbyte_data', ['end_date'], ['end_date']) }} as end_date,
    {{ json_extract_scalar('_airbyte_data', ['daily_cap'], ['daily_cap']) }} as daily_cap,
    {{ json_extract_scalar('_airbyte_data', ['start_date'], ['start_date']) }} as start_date,
    {{ json_extract_scalar('_airbyte_data', ['pace_evenly'], ['pace_evenly']) }} as pace_evenly,
    {{ json_extract_scalar('_airbyte_data', ['revenue_type'], ['revenue_type']) }} as revenue_type,
    {{ json_extract_scalar('_airbyte_data', ['advertiser_id'], ['advertiser_id']) }} as advertiser_id,
    {{ json_extract_scalar('_airbyte_data', ['revenue_value'], ['revenue_value']) }} as revenue_value,
    {{ json_extract_array('_airbyte_data', ['all_campaign_ids'], ['all_campaign_ids']) }} as all_campaign_ids,
    {{ json_extract_scalar('_airbyte_data', ['black_list_options'], ['black_list_options']) }} as black_list_options,
    {{ json_extract_scalar('_airbyte_data', ['purchase_order_number'], ['purchase_order_number']) }} as purchase_order_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_line_items') }}
-- line_items
where 1 = 1

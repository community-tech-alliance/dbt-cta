{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_campaigns') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_array('_airbyte_data', ['adlabels'], ['adlabels']) }} as adlabels,
    {{ json_extract_scalar('_airbyte_data', ['objective'], ['objective']) }} as objective,
    {{ json_extract_scalar('_airbyte_data', ['spend_cap'], ['spend_cap']) }} as spend_cap,
    {{ json_extract_scalar('_airbyte_data', ['stop_time'], ['stop_time']) }} as stop_time,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['buying_type'], ['buying_type']) }} as buying_type,
    {{ json_extract_array('_airbyte_data', ['issues_info'], ['issues_info']) }} as issues_info,
    {{ json_extract_scalar('_airbyte_data', ['bid_strategy'], ['bid_strategy']) }} as bid_strategy,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract_scalar('_airbyte_data', ['daily_budget'], ['daily_budget']) }} as daily_budget,
    {{ json_extract_scalar('_airbyte_data', ['updated_time'], ['updated_time']) }} as updated_time,
    {{ json_extract_scalar('_airbyte_data', ['lifetime_budget'], ['lifetime_budget']) }} as lifetime_budget,
    {{ json_extract_scalar('_airbyte_data', ['budget_remaining'], ['budget_remaining']) }} as budget_remaining,
    {{ json_extract_scalar('_airbyte_data', ['effective_status'], ['effective_status']) }} as effective_status,
    {{ json_extract_scalar('_airbyte_data', ['source_campaign_id'], ['source_campaign_id']) }} as source_campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['special_ad_category'], ['special_ad_category']) }} as special_ad_category,
    {{ json_extract_scalar('_airbyte_data', ['smart_promotion_type'], ['smart_promotion_type']) }} as smart_promotion_type,
    {{ json_extract_scalar('_airbyte_data', ['budget_rebalance_flag'], ['budget_rebalance_flag']) }} as budget_rebalance_flag,
    {{ json_extract_array('_airbyte_data', ['special_ad_category_country'], ['special_ad_category_country']) }} as special_ad_category_country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_campaigns') }} as table_alias
-- campaigns
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


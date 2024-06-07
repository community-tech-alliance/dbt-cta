{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_campaigns" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}

select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['type']) }} as type,
    {{ json_extract('table_alias', '_airbyte_data', ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['web_id'], ['web_id']) }} as web_id,
    {{ json_extract('table_alias', '_airbyte_data', ['rss_opts'], ['rss_opts']) }} as rss_opts,
    {{ json_extract('table_alias', '_airbyte_data', ['settings'], ['settings']) }} as settings,
    {{ json_extract('table_alias', '_airbyte_data', ['tracking'], ['tracking']) }} as tracking,
    {{ json_extract_scalar('_airbyte_data', ['send_time'], ['send_time']) }} as send_time,
    {{ json_extract('table_alias', '_airbyte_data', ['recipients'], ['recipients']) }} as recipients,
    {{ json_extract_scalar('_airbyte_data', ['resendable'], ['resendable']) }} as resendable,
    {{ json_extract_scalar('_airbyte_data', ['archive_url'], ['archive_url']) }} as archive_url,
    {{ json_extract_scalar('_airbyte_data', ['create_time'], ['create_time']) }} as create_time,
    {{ json_extract_scalar('_airbyte_data', ['emails_sent'], ['emails_sent']) }} as emails_sent,
    {{ json_extract('table_alias', '_airbyte_data', ['social_card'], ['social_card']) }} as social_card,
    {{ json_extract_scalar('_airbyte_data', ['content_type'], ['content_type']) }} as content_type,
    {{ json_extract('table_alias', '_airbyte_data', ['ab_split_opts'], ['ab_split_opts']) }} as ab_split_opts,
    {{ json_extract('table_alias', '_airbyte_data', ['report_summary'], ['report_summary']) }} as report_summary,
    {{ json_extract('table_alias', '_airbyte_data', ['delivery_status'], ['delivery_status']) }} as delivery_status,
    {{ json_extract_scalar('_airbyte_data', ['long_archive_url'], ['long_archive_url']) }} as long_archive_url,
    {{ json_extract('table_alias', '_airbyte_data', ['variate_settings'], ['variate_settings']) }} as variate_settings,
    {{ json_extract_scalar('_airbyte_data', ['parent_campaign_id'], ['parent_campaign_id']) }} as parent_campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['needs_block_refresh'], ['needs_block_refresh']) }} as needs_block_refresh,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at

from {{ source('cta_raw', raw_table) }} as table_alias
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

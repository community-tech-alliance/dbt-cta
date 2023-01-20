{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_deliverability_report') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['url_path'], ['url_path']) }} as url_path,
    {{ json_extract_scalar('_airbyte_data', ['count_sent'], ['count_sent']) }} as count_sent,
    {{ json_extract_scalar('_airbyte_data', ['computed_at'], ['computed_at']) }} as computed_at,
    {{ json_extract_scalar('_airbyte_data', ['count_error'], ['count_error']) }} as count_error,
    {{ json_extract_scalar('_airbyte_data', ['count_total'], ['count_total']) }} as count_total,
    {{ json_extract_scalar('_airbyte_data', ['period_ends_at'], ['period_ends_at']) }} as period_ends_at,
    {{ json_extract_scalar('_airbyte_data', ['count_delivered'], ['count_delivered']) }} as count_delivered,
    {{ json_extract_scalar('_airbyte_data', ['period_starts_at'], ['period_starts_at']) }} as period_starts_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_deliverability_report') }} as table_alias
-- deliverability_report
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


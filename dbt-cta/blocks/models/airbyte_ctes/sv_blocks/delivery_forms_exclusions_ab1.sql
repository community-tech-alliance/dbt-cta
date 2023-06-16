{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_delivery_forms_exclusions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_scan_id'], ['voter_registration_scan_id']) }} as voter_registration_scan_id,
    {{ json_extract_scalar('_airbyte_data', ['delivery_id'], ['delivery_id']) }} as delivery_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_delivery_forms_exclusions') }} as table_alias
-- delivery_forms_exclusions
where 1 = 1


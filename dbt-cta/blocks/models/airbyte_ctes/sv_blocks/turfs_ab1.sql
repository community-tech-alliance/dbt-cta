{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_turfs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['van_api_config'], ['van_api_config']) }} as van_api_config,
    {{ json_extract_scalar('_airbyte_data', ['turf_level_id'], ['turf_level_id']) }} as turf_level_id,
    {{ json_extract_scalar('_airbyte_data', ['qc_turnaround_days'], ['qc_turnaround_days']) }} as qc_turnaround_days,
    {{ json_extract_scalar('_airbyte_data', ['default_phone_verification_script_id'], ['default_phone_verification_script_id']) }} as default_phone_verification_script_id,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['petition_requirements'], ['petition_requirements']) }} as petition_requirements,
    {{ json_extract_scalar('_airbyte_data', ['min_phone_verification_rounds'], ['min_phone_verification_rounds']) }} as min_phone_verification_rounds,
    {{ json_extract_scalar('_airbyte_data', ['archived'], ['archived']) }} as archived,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_enabled'], ['voter_registration_enabled']) }} as voter_registration_enabled,
    {{ json_extract_scalar('_airbyte_data', ['depth'], ['depth']) }} as depth,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['qc_config'], ['qc_config']) }} as qc_config,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_config'], ['voter_registration_config']) }} as voter_registration_config,
    {{ json_extract_scalar('_airbyte_data', ['phone_verification_language'], ['phone_verification_language']) }} as phone_verification_language,
    {{ json_extract_scalar('_airbyte_data', ['min_phone_verification_percent'], ['min_phone_verification_percent']) }} as min_phone_verification_percent,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['lft'], ['lft']) }} as lft,
    {{ json_extract_scalar('_airbyte_data', ['rgt'], ['rgt']) }} as rgt,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_turfs') }} as table_alias
-- turfs
where 1 = 1


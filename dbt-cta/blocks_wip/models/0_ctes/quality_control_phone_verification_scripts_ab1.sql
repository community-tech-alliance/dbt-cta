{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_quality_control_phone_verification_scripts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['structure'], ['structure']) }} as structure,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_quality_control_phone_verification_scripts') }} as table_alias
-- quality_control_phone_verification_scripts
where 1 = 1


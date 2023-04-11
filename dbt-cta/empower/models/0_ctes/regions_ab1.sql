{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_empower_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('empower_partner_a', '_airbyte_raw_regions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
    {{ json_extract_scalar('_airbyte_data', ['inviteCodeCreatedMts'], ['inviteCodeCreatedMts']) }} as inviteCodeCreatedMts,
    {{ json_extract_scalar('_airbyte_data', ['ctaId'], ['ctaId']) }} as ctaId,
    {{ json_extract_scalar('_airbyte_data', ['inviteCode'], ['inviteCode']) }} as inviteCode,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('empower_partner_a', '_airbyte_raw_regions') }} as table_alias
-- regions
where 1 = 1


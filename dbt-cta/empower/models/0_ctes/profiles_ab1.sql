{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_profiles') }}
select
    {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('_airbyte_data', ['lastUsedEmpowerMts'], ['lastUsedEmpowerMts']) }} as lastUsedEmpowerMts,
    {{ json_extract_scalar('_airbyte_data', ['eid'], ['eid']) }} as eid,
    {{ json_extract_scalar('_airbyte_data', ['lastName'], ['lastName']) }} as lastName,
    {{ json_extract('table_alias', '_airbyte_data', ['canvassedByCtaId']) }} as canvassedByCtaId,
    {{ json_extract_scalar('_airbyte_data', ['role'], ['role']) }} as role,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['myCampaignVanId'], ['myCampaignVanId']) }} as myCampaignVanId,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract('table_alias', '_airbyte_data', ['address2']) }} as address2,
    {{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as createdMts,
    {{ json_extract_scalar('_airbyte_data', ['parentEid'], ['parentEid']) }} as parentEid,
    {{ json_extract_string_array('_airbyte_data', ['activeCtaIds'], ['activeCtaIds']) }} as activeCtaIds,
    {{ json_extract_scalar('_airbyte_data', ['firstName'], ['firstName']) }} as firstName,
    {{ json_extract_scalar('_airbyte_data', ['currentCtaId'], ['currentCtaId']) }} as currentCtaId,
    {{ json_extract('table_alias', '_airbyte_data', ['vanId']) }} as vanId,
    {{ json_extract_scalar('_airbyte_data', ['updatedMts'], ['updatedMts']) }} as updatedMts,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['regionId'], ['regionId']) }} as regionId,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['relationship'], ['relationship']) }} as relationship,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_profiles') }} as table_alias
-- profiles
where 1 = 1


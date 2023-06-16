{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_organizations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['street_address'], ['street_address']) }} as street_address,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['denominations'], ['denominations']) }} as denominations,
    {{ json_extract_scalar('_airbyte_data', ['leader_id'], ['leader_id']) }} as leader_id,
    {{ json_extract_scalar('_airbyte_data', ['issues'], ['issues']) }} as issues,
    {{ json_extract_scalar('_airbyte_data', ['mailing_zipcode'], ['mailing_zipcode']) }} as mailing_zipcode,
    {{ json_extract_scalar('_airbyte_data', ['soft_member_count'], ['soft_member_count']) }} as soft_member_count,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['membership_type_legacy'], ['membership_type_legacy']) }} as membership_type_legacy,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['membership_type'], ['membership_type']) }} as membership_type,
    {{ json_extract_scalar('_airbyte_data', ['mailing_city'], ['mailing_city']) }} as mailing_city,
    {{ json_extract_scalar('_airbyte_data', ['website'], ['website']) }} as website,
    {{ json_extract_scalar('_airbyte_data', ['contact_name'], ['contact_name']) }} as contact_name,
    {{ json_extract_scalar('_airbyte_data', ['mailing_state'], ['mailing_state']) }} as mailing_state,
    {{ json_extract_scalar('_airbyte_data', ['address_id'], ['address_id']) }} as address_id,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['organization_type'], ['organization_type']) }} as organization_type,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['members_count'], ['members_count']) }} as members_count,
    {{ json_extract_scalar('_airbyte_data', ['influence_level'], ['influence_level']) }} as influence_level,
    {{ json_extract_scalar('_airbyte_data', ['mailing_street_address'], ['mailing_street_address']) }} as mailing_street_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_organizations') }} as table_alias
-- organizations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


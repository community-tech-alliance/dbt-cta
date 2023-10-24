{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_users_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['num_contacts_synced'], ['num_contacts_synced']) }} as num_contacts_synced,
    {{ json_extract_scalar('_airbyte_data', ['selected_voterbase_id'], ['selected_voterbase_id']) }} as selected_voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['recruited_by_id'], ['recruited_by_id']) }} as recruited_by_id,
    {{ json_extract_scalar('_airbyte_data', ['recruited_by'], ['recruited_by']) }} as recruited_by,
    {{ json_extract_scalar('_airbyte_data', ['actions_performed'], ['actions_performed']) }} as actions_performed,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['reports_filled'], ['reports_filled']) }} as reports_filled,
    {{ json_extract_scalar('_airbyte_data', ['van_id'], ['van_id']) }} as van_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['supplied_zip_code'], ['supplied_zip_code']) }} as supplied_zip_code,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['num_contacts_matched_in_district'], ['num_contacts_matched_in_district']) }} as num_contacts_matched_in_district,
    {{ json_extract_scalar('_airbyte_data', ['actions_completed'], ['actions_completed']) }} as actions_completed,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['num_contacts_matched'], ['num_contacts_matched']) }} as num_contacts_matched,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['supplied_state_abbrev'], ['supplied_state_abbrev']) }} as supplied_state_abbrev,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['invites_sent'], ['invites_sent']) }} as invites_sent,
    {{ json_extract_scalar('_airbyte_data', ['last_active_at'], ['last_active_at']) }} as last_active_at,
    {{ json_extract_scalar('_airbyte_data', ['last_seen_at'], ['last_seen_at']) }} as last_seen_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_users_export') }} as table_alias
-- users_export
where 1 = 1


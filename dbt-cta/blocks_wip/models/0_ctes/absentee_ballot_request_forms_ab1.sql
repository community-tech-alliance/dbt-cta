{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_absentee_ballot_request_forms') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('_airbyte_data', ['eligible_voting_age'], ['eligible_voting_age']) }} as eligible_voting_age,
    {{ json_extract_scalar('_airbyte_data', ['batch_id'], ['batch_id']) }} as batch_id,
    {{ json_extract_scalar('_airbyte_data', ['name_suffix'], ['name_suffix']) }} as name_suffix,
    {{ json_extract_scalar('_airbyte_data', ['date_of_birth'], ['date_of_birth']) }} as date_of_birth,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['us_citizen'], ['us_citizen']) }} as us_citizen,
    {{ json_extract_scalar('_airbyte_data', ['residential_address_id'], ['residential_address_id']) }} as residential_address_id,
    {{ json_extract_scalar('_airbyte_data', ['email_address'], ['email_address']) }} as email_address,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['shift_id'], ['shift_id']) }} as shift_id,
    {{ json_extract_scalar('_airbyte_data', ['election_id'], ['election_id']) }} as election_id,
    {{ json_extract_scalar('_airbyte_data', ['request_date'], ['request_date']) }} as request_date,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['ballot_delivery_address_id'], ['ballot_delivery_address_id']) }} as ballot_delivery_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_absentee_ballot_request_forms') }} as table_alias
-- absentee_ballot_request_forms
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


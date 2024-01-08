{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_import_lcv') }}
select
    {{ json_extract_scalar('_airbyte_data', ['citizen'], ['citizen']) }} as citizen,
    {{ json_extract_scalar('_airbyte_data', ['date_delivered'], ['date_delivered']) }} as date_delivered,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['signature'], ['signature']) }} as signature,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['ssn'], ['ssn']) }} as ssn,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['signature_date'], ['signature_date']) }} as signature_date,
    {{ json_extract_scalar('_airbyte_data', ['dob'], ['dob']) }} as dob,
    {{ json_extract_scalar('_airbyte_data', ['organizer'], ['organizer']) }} as organizer,
    {{ json_extract_scalar('_airbyte_data', ['restored'], ['restored']) }} as restored,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as location,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('_airbyte_data', ['felony'], ['felony']) }} as felony,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_import_lcv') }}
-- import_lcv
where 1 = 1

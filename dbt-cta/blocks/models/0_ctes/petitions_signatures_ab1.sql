{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_petitions_signatures') }}
select
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['address_two'], ['address_two']) }} as address_two,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['petition_packet_id'], ['petition_packet_id']) }} as petition_packet_id,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['voter_match_status'], ['voter_match_status']) }} as voter_match_status,
    {{ json_extract_scalar('_airbyte_data', ['page_number'], ['page_number']) }} as page_number,
    {{ json_extract_scalar('_airbyte_data', ['signature_date'], ['signature_date']) }} as signature_date,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['address_one'], ['address_one']) }} as address_one,
    {{ json_extract_scalar('_airbyte_data', ['line_number'], ['line_number']) }} as line_number,
    {{ json_extract_scalar('_airbyte_data', ['signature_exists'], ['signature_exists']) }} as signature_exists,
    {{ json_extract_scalar('_airbyte_data', ['reviewer_id'], ['reviewer_id']) }} as reviewer_id,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['petition_page_id'], ['petition_page_id']) }} as petition_page_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_petitions_signatures') }}
-- petitions_signatures
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


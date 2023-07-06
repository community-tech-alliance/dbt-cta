{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_petitions_pages') }}
select
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['possible_fraud'], ['possible_fraud']) }} as possible_fraud,
    {{ json_extract_scalar('_airbyte_data', ['box_number'], ['box_number']) }} as box_number,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['notary_date'], ['notary_date']) }} as notary_date,
    {{ json_extract_scalar('_airbyte_data', ['notary_id'], ['notary_id']) }} as notary_id,
    {{ json_extract_scalar('_airbyte_data', ['signatures_count'], ['signatures_count']) }} as signatures_count,
    {{ json_extract_scalar('_airbyte_data', ['notary_seal'], ['notary_seal']) }} as notary_seal,
    {{ json_extract_scalar('_airbyte_data', ['petition_book_id'], ['petition_book_id']) }} as petition_book_id,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_id'], ['canvasser_id']) }} as canvasser_id,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['notary_signature'], ['notary_signature']) }} as notary_signature,
    {{ json_extract_scalar('_airbyte_data', ['signers_county'], ['signers_county']) }} as signers_county,
    {{ json_extract_scalar('_airbyte_data', ['scan_file_data'], ['scan_file_data']) }} as scan_file_data,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['scan_number'], ['scan_number']) }} as scan_number,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_signature'], ['canvasser_signature']) }} as canvasser_signature,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['notary_county'], ['notary_county']) }} as notary_county,
    {{ json_extract_scalar('_airbyte_data', ['shift_id'], ['shift_id']) }} as shift_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_petitions_pages') }} as table_alias
-- petitions_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


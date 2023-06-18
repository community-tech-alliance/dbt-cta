{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_voter_histories') }}
select
    {{ json_extract_scalar('_airbyte_data', ['pct_label'], ['pct_label']) }} as pct_label,
    {{ json_extract_scalar('_airbyte_data', ['vtd_label'], ['vtd_label']) }} as vtd_label,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['voter_reg_number'], ['voter_reg_number']) }} as voter_reg_number,
    {{ json_extract_scalar('_airbyte_data', ['voter_state'], ['voter_state']) }} as voter_state,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['voted_party_code'], ['voted_party_code']) }} as voted_party_code,
    {{ json_extract_scalar('_airbyte_data', ['voted_county_id'], ['voted_county_id']) }} as voted_county_id,
    {{ json_extract_scalar('_airbyte_data', ['election_id'], ['election_id']) }} as election_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['voting_method'], ['voting_method']) }} as voting_method,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_voter_histories') }} as table_alias
-- voter_histories
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


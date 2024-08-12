{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_customers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_array('_airbyte_data', ['cards'], ['cards']) }} as cards,
    {{ json_extract('table_alias', '_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('_airbyte_data', ['birthday'], ['birthday']) }} as birthday,
    {{ json_extract_string_array('_airbyte_data', ['group_ids'], ['group_ids']) }} as group_ids,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['given_name'], ['given_name']) }} as given_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['family_name'], ['family_name']) }} as family_name,
    {{ json_extract('table_alias', '_airbyte_data', ['preferences'], ['preferences']) }} as preferences,
    {{ json_extract_string_array('_airbyte_data', ['segment_ids'], ['segment_ids']) }} as segment_ids,
    {{ json_extract_scalar('_airbyte_data', ['company_name'], ['company_name']) }} as company_name,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['reference_id'], ['reference_id']) }} as reference_id,
    {{ json_extract_scalar('_airbyte_data', ['email_address'], ['email_address']) }} as email_address,
    {{ json_extract_scalar('_airbyte_data', ['creation_source'], ['creation_source']) }} as creation_source,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_customers') }} as table_alias
-- customers
where 1 = 1

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_teachers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['congressional_district'], ['congressional_district']) }} as congressional_district,
    {{ json_extract_scalar('_airbyte_data', ['customer_address_id'], ['customer_address_id']) }} as customer_address_id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['state_senate_district'], ['state_senate_district']) }} as state_senate_district,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['address_two'], ['address_two']) }} as address_two,
    {{ json_extract_scalar('_airbyte_data', ['county_name'], ['county_name']) }} as county_name,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['county_fips'], ['county_fips']) }} as county_fips,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['state_house_district'], ['state_house_district']) }} as state_house_district,
    {{ json_extract_scalar('_airbyte_data', ['address_one'], ['address_one']) }} as address_one,
    {{ json_extract_scalar('_airbyte_data', ['census_block'], ['census_block']) }} as census_block,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_teachers') }}
-- teachers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


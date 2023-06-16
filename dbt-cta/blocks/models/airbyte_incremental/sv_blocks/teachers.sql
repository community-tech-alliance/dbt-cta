{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teachers_scd') }}
select
    congressional_district,
    customer_address_id,
    city,
    latitude,
    state_senate_district,
    last_name,
    created_at,
    address_two,
    county_name,
    zipcode,
    county_fips,
    updated_at,
    state_house_district,
    address_one,
    census_block,
    organization_id,
    id,
    state,
    first_name,
    longitude,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_teachers_hashid
from {{ ref('teachers_scd') }}
-- teachers from {{ source('sv_blocks', '_airbyte_raw_teachers') }}


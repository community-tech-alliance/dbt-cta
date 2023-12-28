{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('addresses_ab3') }}
select
    line_three,
    city,
    line_one,
    county,
    created_at,
    zipcode,
    county_id,
    updated_at,
    line_four,
    id,
    state,
    line_two,
    tsv_full_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addresses_hashid
from {{ ref('addresses_ab3') }}
-- addresses from {{ source('cta', '_airbyte_raw_addresses') }}

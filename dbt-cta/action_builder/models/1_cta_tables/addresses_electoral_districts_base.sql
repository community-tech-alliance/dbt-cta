{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('addresses_electoral_districts_ab3') }}
select
    address_id,
    electoral_district_ocd_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addresses_electoral_districts_hashid
from {{ ref('addresses_electoral_districts_ab3') }}
-- addresses_electoral_districts from {{ source('cta', '_airbyte_raw_addresses_electoral_districts') }}
where 1 = 1


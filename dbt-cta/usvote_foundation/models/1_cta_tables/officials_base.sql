{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "usvote_foundation",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('officials_ab3') }}
select
    id,
    fax,
    email,
    phone,
    title,
    office,
    suffix,
    initial,
    last_name,
    first_name,
    office_name,
    office_type,
    resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_officials_hashid
from {{ ref('officials_ab3') }}
-- officials from {{ source('cta', '_airbyte_raw_officials') }}
where 1 = 1


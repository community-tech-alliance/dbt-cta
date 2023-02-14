{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "usvote_foundation",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('offices_officials_ab3') }}
select
    _airbyte_offices_hashid,
    id,
    fax,
    email,
    phone,
    title,
    suffix,
    initial,
    last_name,
    first_name,
    office_uri,
    office_type,
    resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_officials_hashid
from {{ ref('offices_officials_ab3') }}
-- officials at offices/officials from {{ ref('offices') }}
where 1 = 1


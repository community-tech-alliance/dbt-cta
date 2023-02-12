{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tickets_ab3') }}
select
    id,
    price,
    title,
    total,
    hidden,
    available,
    created_at,
    updated_at,
    description,
    ticketed_event_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tickets_hashid
from {{ ref('tickets_ab3') }}
-- tickets from {{ source('cta', '_airbyte_raw_tickets') }}
where 1 = 1

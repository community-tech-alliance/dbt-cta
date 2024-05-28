{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tickets_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tickets_hashid
from {{ ref('tickets_ab4') }}

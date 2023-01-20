{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('contact_statuses_ab3') }}
select
    id,
    name,
    created_at,
    sort_order,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contact_statuses_hashid
from {{ ref('contact_statuses_ab3') }}
-- contact_statuses from {{ source('cta', '_airbyte_raw_contact_statuses') }}
where 1 = 1


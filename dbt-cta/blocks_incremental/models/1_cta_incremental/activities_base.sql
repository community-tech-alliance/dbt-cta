{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('activities_ab4') }}
select
    recipient_type,
    trackable_id,
    updated_at,
    owner_id,
    created_at,
    id,
    trackable_type,
    parameters,
    key,
    owner_type,
    recipient_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_activities_hashid
from {{ ref('activities_ab4') }}
-- activities from {{ source('cta', '_airbyte_raw_activities') }}

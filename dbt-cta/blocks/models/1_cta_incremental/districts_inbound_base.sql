{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('districts_inbound_ab3') }}
select
    district_name,
    updated_at,
    extras,
    created_at,
    id,
    state,
    district_type_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_districts_inbound_hashid
from {{ ref('districts_inbound_ab3') }}

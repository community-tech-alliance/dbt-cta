{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "usvote_foundation",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('states_ab3') }}
select
    id,
    abbr,
    name,
    resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_states_hashid
from {{ ref('states_ab3') }}
-- states from {{ source('usvote_foundation', '_airbyte_raw_states') }}
where 1 = 1

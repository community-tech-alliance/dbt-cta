{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('voter_sources_scd') }}
select
    updated_at,
    date_obtained,
    created_at,
    description,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_sources_hashid
from {{ ref('voter_sources_scd') }}
-- voter_sources from {{ source('sv_blocks', '_airbyte_raw_voter_sources') }}


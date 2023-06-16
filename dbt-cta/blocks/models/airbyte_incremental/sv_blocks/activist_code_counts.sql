{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('activist_code_counts_ab3') }}
select
    updated_at,
    turf_id,
    activist_code_id,
    count,
    created_at,
    id,
    datecanvassed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_activist_code_counts_hashid
from {{ ref('activist_code_counts_ab3') }}
-- activist_code_counts from {{ source('sv_blocks', '_airbyte_raw_activist_code_counts') }}


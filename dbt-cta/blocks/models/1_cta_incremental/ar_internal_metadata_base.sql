{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('ar_internal_metadata_ab3') }}
select
    updated_at,
    created_at,
    value,
    key,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ar_internal_metadata_hashid
from {{ ref('ar_internal_metadata_ab3') }}
-- ar_internal_metadata from {{ source('cta', '_airbyte_raw_ar_internal_metadata') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('zip_code_ab3') }}
select
    zip,
    city,
    latitude,
    timezone_offset,
    state,
    has_dst,
    longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_zip_code_hashid
from {{ ref('zip_code_ab3') }}
-- zip_code from {{ source('cta', '_airbyte_raw_zip_code') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


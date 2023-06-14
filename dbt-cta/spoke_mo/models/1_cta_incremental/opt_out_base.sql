{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('opt_out_ab3') }}
select
    reason_code,
    assignment_id,
    organization_id,
    created_at,
    id,
    cell,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_opt_out_hashid
from {{ ref('opt_out_ab3') }}
-- opt_out from {{ source('cta', '_airbyte_raw_opt_out') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


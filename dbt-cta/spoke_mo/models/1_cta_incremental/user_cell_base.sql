{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_cell_ab3') }}
select
    is_primary,
    user_id,
    service,
    id,
    cell,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_cell_hashid
from {{ ref('user_cell_ab3') }}
-- user_cell from {{ source('cta', '_airbyte_raw_user_cell') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

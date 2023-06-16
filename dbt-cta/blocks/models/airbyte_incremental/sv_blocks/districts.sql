{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('districts_scd') }}
select
    _airbyte_unique_key,
    district_name,
    updated_at,
    extras,
    created_at,
    id,
    state,
    district_type,
    district_type_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_districts_hashid
from {{ ref('districts_scd') }}
-- districts from {{ source('sv_blocks', '_airbyte_raw_districts') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}


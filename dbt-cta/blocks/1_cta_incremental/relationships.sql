{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('relationships_scd') }}
select
    _airbyte_unique_key,
    first_person_id,
    updated_at,
    relationship_type_id,
    second_person_id,
    created_at,
    id,
    type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_relationships_hashid
from {{ ref('relationships_scd') }}
-- relationships from {{ source('sv_blocks', '_airbyte_raw_relationships') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}


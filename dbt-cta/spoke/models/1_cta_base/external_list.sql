{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('external_list_ab3') }}
select
    name,
    system_id,
    created_at,
    door_count,
    list_count,
    updated_at,
    description,
    external_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_external_list_hashid
from {{ ref('external_list_ab3') }}
-- external_list from {{ source('public', '_airbyte_raw_external_list') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


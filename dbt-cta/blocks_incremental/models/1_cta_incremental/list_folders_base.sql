{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('list_folders_ab4') }}
select
    updated_at,
    user_id,
    name,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_list_folders_hashid
from {{ ref('list_folders_ab4') }}
-- list_folders from {{ source('cta', '_airbyte_raw_list_folders') }}

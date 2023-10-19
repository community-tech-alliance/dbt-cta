{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_ab4') }}
select
    is_deleted,
    updated_at,
    organization_id,
    name,
    created_at,
    description,
    id,
    {{ adapter.quote('group') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_hashid
from {{ ref('tag_ab4') }}
-- tag from {{ source('cta', '_airbyte_raw_tag') }}
where 1=1


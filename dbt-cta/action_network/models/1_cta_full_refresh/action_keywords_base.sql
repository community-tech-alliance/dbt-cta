{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_keywords_ab3') }}
select
    id,
    text,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_keywords_hashid
from {{ ref('action_keywords_ab3') }}
-- action_keywords from {{ source('cta', '_airbyte_raw_action_keywords') }}
where 1 = 1


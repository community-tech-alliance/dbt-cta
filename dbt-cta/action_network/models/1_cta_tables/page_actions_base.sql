{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_actions_ab3') }}
select
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    page_wrapper_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_page_actions_hashid
from {{ ref('page_actions_ab3') }}
-- page_actions from {{ source('cta', '_airbyte_raw_page_actions') }}
where 1 = 1


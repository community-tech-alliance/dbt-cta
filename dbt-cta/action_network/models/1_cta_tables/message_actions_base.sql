{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('message_actions_ab3') }}
select
    id,
    referrer,
    action_id,
    created_at,
    sending_id,
    updated_at,
    action_type,
    sending_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_actions_hashid
from {{ ref('message_actions_ab3') }}
-- message_actions from {{ source('cta', '_airbyte_raw_message_actions') }}
where 1 = 1


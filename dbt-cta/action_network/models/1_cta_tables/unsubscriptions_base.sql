{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('unsubscriptions_ab3') }}
select
    id,
    reason,
    user_id,
    email_id,
    group_id,
    new_user,
    processed,
    created_at,
    subject_id,
    updated_at,
    source_code,
    http_referer,
    custom_fields,
    subscriber_id,
    source_action_id,
    source_action_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_unsubscriptions_hashid
from {{ ref('unsubscriptions_ab3') }}
-- unsubscriptions from {{ source('cta', '_airbyte_raw_unsubscriptions') }}
where 1 = 1


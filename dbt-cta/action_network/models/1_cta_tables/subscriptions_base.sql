{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscriptions_ab3') }}
select
    id,
    amount,
    status,
    user_id,
    group_id,
    new_user,
    processed,
    created_at,
    salesforce,
    updated_at,
    source_code,
    http_referer,
    custom_fields,
    salesforce_id,
    subscriber_id,
    user_action_id,
    network_group_id,
    source_action_id,
    source_action_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_subscriptions_hashid
from {{ ref('subscriptions_ab3') }}
-- subscriptions from {{ source('cta', '_airbyte_raw_subscriptions') }}
where 1 = 1

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscriptions_1_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_subscriptions_1_hashid
from {{ ref('subscriptions_1_ab4') }}

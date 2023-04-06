{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscription_statuses_ab3') }}
select
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    created_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_subscription_statuses_hashid
from {{ ref('subscription_statuses_ab3') }}
-- subscription_statuses from {{ source('cta', '_airbyte_raw_subscription_statuses') }}
where 1 = 1


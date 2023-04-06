{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('webhooks_ab3') }}
select
    id,
    name,
    status,
    group_id,
    created_at,
    target_url,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_webhooks_hashid
from {{ ref('webhooks_ab3') }}
-- webhooks from {{ source('cta', '_airbyte_raw_webhooks') }}
where 1 = 1


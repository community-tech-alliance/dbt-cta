{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_ab3') }}
select
    id,
    data,
    type,
    object,
    created,
    request,
    livemode,
    api_version,
    pending_webhooks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_events_hashid
from {{ ref('events_ab3') }}
-- events from {{ source('stripe_partner_a', '_airbyte_raw_events') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


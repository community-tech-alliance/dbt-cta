{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('assignable_needs_message_ab3') }}
select
    id,
    campaign_id,
    message_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_assignable_needs_message_hashid
from {{ ref('assignable_needs_message_ab3') }}
-- assignable_needs_message from {{ source('public', '_airbyte_raw_assignable_needs_message') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


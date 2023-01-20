{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('assignable_campaigns_with_needs_reply_ab3') }}
select
    id,
    title,
    autosend_status,
    organization_id,
    limit_assignment_to_teams,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_assignable_campaigns_with_needs_reply_hashid
from {{ ref('assignable_campaigns_with_needs_reply_ab3') }}
-- assignable_campaigns_with_needs_reply from {{ source('public', '_airbyte_raw_assignable_campaigns_with_needs_reply') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


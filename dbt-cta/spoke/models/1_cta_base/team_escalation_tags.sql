{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_escalation_tags_ab3') }}
select
    id,
    tag_id,
    team_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_escalation_tags_hashid
from {{ ref('team_escalation_tags_ab3') }}
-- team_escalation_tags from {{ source('public', '_airbyte_raw_team_escalation_tags') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


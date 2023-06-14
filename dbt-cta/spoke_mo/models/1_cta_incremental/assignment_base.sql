{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('assignment_ab3') }}
select
    max_contacts,
    user_id,
    created_at,
    id,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_assignment_hashid
from {{ ref('assignment_ab3') }}
-- assignment from {{ source('cta', '_airbyte_raw_assignment') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


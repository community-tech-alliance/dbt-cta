{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_activities_10_ab3') }}
select
    id,
    link_id,
    user_id,
    email_id,
    group_id,
    created_at,
    subject_id,
    updated_at,
    action_type,
    recipient_id,
    email_stat_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_activities_10_hashid
from {{ ref('email_activities_10_ab3') }}
-- email_activities_10 from {{ source('cta', '_airbyte_raw_email_activities_10') }}
where 1 = 1

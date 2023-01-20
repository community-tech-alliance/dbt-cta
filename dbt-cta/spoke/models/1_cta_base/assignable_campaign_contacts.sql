{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('assignable_campaign_contacts_ab3') }}
select
    id,
    campaign_id,
    message_status,
    contact_timezone,
    texting_hours_end,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_assignable_campaign_contacts_hashid
from {{ ref('assignable_campaign_contacts_ab3') }}
-- assignable_campaign_contacts from {{ source('public', '_airbyte_raw_assignable_campaign_contacts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


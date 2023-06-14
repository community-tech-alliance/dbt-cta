{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_campaign_contact_ab3') }}
select
    campaign_contact_id,
    updated_at,
    tag_id,
    created_at,
    id,
    value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_campaign_contact_hashid
from {{ ref('tag_campaign_contact_ab3') }}
-- tag_campaign_contact from {{ source('cta', '_airbyte_raw_tag_campaign_contact') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_campaign_contact_ab4') }}
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
from {{ ref('tag_campaign_contact_ab4') }}
-- tag_campaign_contact from {{ source('cta', '_airbyte_raw_tag_campaign_contact') }}
where 1=1


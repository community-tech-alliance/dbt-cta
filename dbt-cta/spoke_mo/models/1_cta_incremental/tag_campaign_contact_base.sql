{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_campaign_contact_hashid
from {{ ref('tag_campaign_contact_ab4') }}
where 1 = 1

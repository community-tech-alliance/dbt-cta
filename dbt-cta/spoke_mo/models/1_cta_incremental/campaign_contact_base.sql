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
-- depends_on: {{ ref('campaign_contact_ab4') }}
select
    zip,
    custom_fields,
    timezone_offset,
    is_opted_out,
    last_name,
    created_at,
    external_id,
    cell,
    assignment_id,
    message_status,
    updated_at,
    error_code,
    id,
    first_name,
    campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_contact_hashid
from {{ ref('campaign_contact_ab4') }}
where 1=1


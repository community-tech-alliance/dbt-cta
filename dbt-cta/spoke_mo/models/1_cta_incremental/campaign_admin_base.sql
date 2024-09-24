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
-- depends_on: {{ ref('campaign_admin_ab4') }}
select
    ingest_method,
    ingest_data_reference,
    deleted_optouts_count,
    updated_at,
    ingest_success,
    created_at,
    id,
    ingest_result,
    duplicate_contacts_count,
    contacts_count,
    campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_admin_hashid
from {{ ref('campaign_admin_ab4') }}
where 1 = 1

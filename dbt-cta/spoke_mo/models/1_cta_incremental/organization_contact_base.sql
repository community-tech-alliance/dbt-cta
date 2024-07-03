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
-- depends_on: {{ ref('organization_contact_ab4') }}
select
    carrier,
    last_lookup,
    lookup_name,
    status_code,
    subscribe_status,
    service,
    organization_id,
    created_at,
    id,
    contact_number,
    user_number,
    last_error_code,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_contact_hashid
from {{ ref('organization_contact_ab4') }}
where 1=1


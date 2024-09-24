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
-- depends_on: {{ ref('owned_phone_number_ab4') }}
select
    service,
    allocated_to_id,
    area_code,
    service_id,
    allocated_to,
    organization_id,
    created_at,
    phone_number,
    id,
    allocated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_owned_phone_number_hashid
from {{ ref('owned_phone_number_ab4') }}
where 1 = 1

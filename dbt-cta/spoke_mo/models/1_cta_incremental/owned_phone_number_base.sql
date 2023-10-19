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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_owned_phone_number_hashid
from {{ ref('owned_phone_number_ab4') }}
-- owned_phone_number from {{ source('cta', '_airbyte_raw_owned_phone_number') }}
where 1=1


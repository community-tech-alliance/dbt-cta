{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('owned_phone_number_ab3') }}
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
from {{ ref('owned_phone_number_ab3') }}
-- owned_phone_number from {{ source('cta', '_airbyte_raw_owned_phone_number') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


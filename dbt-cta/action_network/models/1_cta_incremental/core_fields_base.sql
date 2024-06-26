{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('core_fields_ab4') }}
select
    id,
    city,
    phone,
    state,
    street,
    country,
    user_id,
    language,
    latitude,
    owner_id,
    zip_code,
    last_name,
    longitude,
    created_at,
    first_name,
    owner_type,
    updated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_core_fields_hashid
from {{ ref('core_fields_ab4') }}

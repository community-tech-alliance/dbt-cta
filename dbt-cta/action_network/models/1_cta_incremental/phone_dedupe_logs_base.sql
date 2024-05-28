{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_dedupe_logs_ab4') }}
select
    id,
    phone,
    owner_id,
    source_id,
    created_at,
    owner_type,
    updated_at,
    source_type,
    kept_core_field_id,
    removed_core_field_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_dedupe_logs_hashid
from {{ ref('phone_dedupe_logs_ab4') }}
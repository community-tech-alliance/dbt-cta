{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('source_codes_ab4') }}
select
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_source_codes_hashid
from {{ ref('source_codes_ab4') }}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('field_values_ab4') }}
select
    id,
    uuid,
    value,
    user_id,
    created_at,
    updated_at,
    field_name_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_field_values_hashid
from {{ ref('field_values_ab4') }}

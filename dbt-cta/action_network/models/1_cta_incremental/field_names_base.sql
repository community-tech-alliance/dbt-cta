{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('field_names_ab4') }}
select
    id,
    name,
    uuid,
    notes,
    hidden,
    owner_id,
    created_at,
    owner_type,
    syndicated,
    updated_at,
    validation_regexp,
    validation_description,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_field_names_hashid
from {{ ref('field_names_ab4') }}
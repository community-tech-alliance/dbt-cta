{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_message_fields_ab4') }}
select
    id,
    text,
    title,
    created_at,
    field_type,
    updated_at,
    mobile_message_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_message_fields_hashid
from {{ ref('mobile_message_fields_ab4') }}

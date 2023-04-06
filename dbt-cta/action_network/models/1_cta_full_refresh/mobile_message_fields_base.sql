{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_message_fields_ab3') }}
select
    id,
    text,
    title,
    created_at,
    field_type,
    updated_at,
    mobile_message_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_message_fields_hashid
from {{ ref('mobile_message_fields_ab3') }}
-- mobile_message_fields from {{ source('cta', '_airbyte_raw_mobile_message_fields') }}
where 1 = 1


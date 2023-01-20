{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_fields_ab3') }}
select
    id,
    position,
    action_id,
    created_at,
    updated_at,
    is_optional,
    object_type,
    object_attribute,
    related_object_id,
    default_response_id,
    related_object_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_fields_hashid
from {{ ref('action_fields_ab3') }}
-- action_fields from {{ source('cta', '_airbyte_raw_action_fields') }}
where 1 = 1


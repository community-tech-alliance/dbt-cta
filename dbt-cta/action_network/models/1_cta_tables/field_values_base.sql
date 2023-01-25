{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('field_values_ab3') }}
select
    id,
    uuid,
    value,
    user_id,
    created_at,
    updated_at,
    field_name_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_field_values_hashid
from {{ ref('field_values_ab3') }}
-- field_values from {{ source('cta', '_airbyte_raw_field_values') }}
where 1 = 1


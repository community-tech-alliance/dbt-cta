{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('entity_types_ab3') }}
select
    id,
    icon,
    name_type,
    created_at,
    updated_at,
    interact_id,
    name_plural,
    email_enabled,
    name_singular,
    address_enabled,
    language_enabled,
    phone_number_enabled,
    date_of_birth_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entity_types_hashid
from {{ ref('entity_types_ab3') }}
-- entity_types from {{ source('cta', '_airbyte_raw_entity_types') }}
where 1 = 1


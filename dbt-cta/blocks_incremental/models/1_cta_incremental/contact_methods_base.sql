{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('contact_methods_ab3') }}
select
    extension,
    contact_type,
    updated_at,
    invalid,
    created_at,
    description,
    id,
    content,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contact_methods_hashid
from {{ ref('contact_methods_ab3') }}
-- contact_methods from {{ source('cta', '_airbyte_raw_contact_methods') }}


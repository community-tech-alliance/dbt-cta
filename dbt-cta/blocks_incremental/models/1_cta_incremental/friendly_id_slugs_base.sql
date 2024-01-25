{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('friendly_id_slugs_ab4') }}
select
    sluggable_type,
    scope,
    sluggable_id,
    created_at,
    id,
    slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_friendly_id_slugs_hashid
from {{ ref('friendly_id_slugs_ab4') }}
-- friendly_id_slugs from {{ source('cta', '_airbyte_raw_friendly_id_slugs') }}

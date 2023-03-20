{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('uploads_ab3') }}
select
    id,
    key,
    name,
    bucket,
    counts,
    result,
    status,
    mappings,
    created_at,
    updated_at,
    campaign_id,
    upload_type,
    created_by_id,
    entity_type_id,
    visibility_status,
    processing_options,
    identification_field,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_uploads_hashid
from {{ ref('uploads_ab3') }}
-- uploads from {{ source('cta', '_airbyte_raw_uploads') }}
where 1 = 1


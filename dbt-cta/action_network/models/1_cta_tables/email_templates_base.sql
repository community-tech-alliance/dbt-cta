{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_templates_ab3') }}
select
    id,
    name,
    uuid,
    notes,
    footer,
    header,
    user_id,
    group_id,
    created_at,
    syndicated,
    updated_at,
    from_suffix,
    unsubscribe,
    logo_file_name,
    logo_file_size,
    logo_dimensions,
    logo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_templates_hashid
from {{ ref('email_templates_ab3') }}
-- email_templates from {{ source('cta', '_airbyte_raw_email_templates') }}
where 1 = 1

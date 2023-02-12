{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_fields_ab3') }}
select
    id,
    text,
    title,
    email_id,
    created_at,
    field_type,
    updated_at,
    builder_html,
    builder_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_fields_hashid
from {{ ref('email_fields_ab3') }}
-- email_fields from {{ source('cta', '_airbyte_raw_email_fields') }}
where 1 = 1

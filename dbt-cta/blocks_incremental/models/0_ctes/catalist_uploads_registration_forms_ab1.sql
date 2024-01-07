{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_catalist_uploads_registration_forms') }}
select
    {{ json_extract_scalar('_airbyte_data', ['registration_form_id'], ['registration_form_id']) }} as registration_form_id,
    {{ json_extract_scalar('_airbyte_data', ['catalist_upload_id'], ['catalist_upload_id']) }} as catalist_upload_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_catalist_uploads_registration_forms') }}
-- catalist_uploads_registration_forms
where 1 = 1

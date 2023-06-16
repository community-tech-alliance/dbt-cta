{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('catalist_uploads_scd') }}
select
    _airbyte_unique_key,
    updated_at,
    remote_file_url,
    remote_id,
    created_at,
    id,
    uuid,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_catalist_uploads_hashid
from {{ ref('catalist_uploads_scd') }}
-- catalist_uploads from {{ source('sv_blocks', '_airbyte_raw_catalist_uploads') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('import_files_scd') }}
select
    _airbyte_unique_key,
    tenant_id,
    updated_at,
    user_id,
    file_name_data,
    created_at,
    id,
    encoding,
    file_size,
    row_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_import_files_hashid
from {{ ref('import_files_scd') }}
-- import_files from {{ source('sv_blocks', '_airbyte_raw_import_files') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}


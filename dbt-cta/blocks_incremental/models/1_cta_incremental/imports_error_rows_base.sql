{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('imports_error_rows_ab3') }}
select
    errors_triggered,
    import_id,
    id,
    row_data,
    duplicate_found,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_imports_error_rows_hashid
from {{ ref('imports_error_rows_ab3') }}
-- imports_error_rows from {{ source('cta', '_airbyte_raw_imports_error_rows') }}

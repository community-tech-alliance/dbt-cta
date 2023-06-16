{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('imports_error_rows_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'errors_triggered',
        'import_id',
        'id',
        'row_data',
        boolean_to_string('duplicate_found'),
    ]) }} as _airbyte_imports_error_rows_hashid,
    tmp.*
from {{ ref('imports_error_rows_ab2') }} tmp
-- imports_error_rows
where 1 = 1


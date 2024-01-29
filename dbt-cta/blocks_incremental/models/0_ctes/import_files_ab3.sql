{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('import_files_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'tenant_id',
        'updated_at',
        'user_id',
        'file_name_data',
        'created_at',
        'id',
        'encoding',
        'file_size',
        'row_count',
    ]) }} as _airbyte_import_files_hashid,
    tmp.*
from {{ ref('import_files_ab2') }} as tmp
-- import_files
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


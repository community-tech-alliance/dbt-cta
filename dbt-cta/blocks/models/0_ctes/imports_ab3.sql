{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('imports_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'mapping',
        'list_id',
        'created_at',
        boolean_to_string('for_phone_bank'),
        'stored_spreadsheet_data',
        'original_spreadsheet_data',
        'record_type',
        'imported_rows_count',
        'mappings',
        'updated_at',
        'user_id',
        'worker_jid',
        'id',
        'status',
    ]) }} as _airbyte_imports_hashid,
    tmp.*
from {{ ref('imports_ab2') }} tmp
-- imports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


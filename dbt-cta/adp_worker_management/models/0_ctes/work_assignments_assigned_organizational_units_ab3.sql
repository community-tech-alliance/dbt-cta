{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_work_assignments_assigned_organizational_units_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('work_assignments_assigned_organizational_units_ab2') }}

select
    {{ dbt_utils.generate_surrogate_key([
        'associateOID',
        'itemID',
        'nameCode_codeValue',
        'nameCode_shortName',
        'typeCode_codeValue',
        'typeCode_shortName',
    ]) }} as _airbyte_work_assignments_assigned_organizational_units_hashid,
    tmp.*
from {{ ref('work_assignments_assigned_organizational_units_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

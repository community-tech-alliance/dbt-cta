{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('volunteerships_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'event_shift_id',
        'updated_at',
        'user_id',
        'responsibility',
        'created_at',
        'id',
        'responsibility_id',
        'person_id',
    ]) }} as _airbyte_volunteerships_hashid,
    tmp.*
from {{ ref('volunteerships_ab2') }} as tmp
-- volunteerships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


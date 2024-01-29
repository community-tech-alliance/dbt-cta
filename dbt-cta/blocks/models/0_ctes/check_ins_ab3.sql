{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('check_ins_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'end_date',
        'updated_at',
        'turf_id',
        'created_at',
        array_to_string('days_of_the_week'),
        'id',
    ]) }} as _airbyte_check_ins_hashid,
    tmp.*
from {{ ref('check_ins_ab2') }} tmp
-- check_ins
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


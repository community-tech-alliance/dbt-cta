{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('elections_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'date',
        'updated_at',
        'created_at',
        'description',
        'id',
        'state',
    ]) }} as _airbyte_elections_hashid,
    tmp.*
from {{ ref('elections_ab2') }} tmp
-- elections
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


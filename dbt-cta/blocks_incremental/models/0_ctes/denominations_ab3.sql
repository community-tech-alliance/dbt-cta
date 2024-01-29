{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('denominations_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'created_at',
        'description',
        'id',
    ]) }} as _airbyte_denominations_hashid,
    tmp.*
from {{ ref('denominations_ab2') }} as tmp
-- denominations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


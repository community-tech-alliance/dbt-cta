{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('filters_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'total',
        'params',
        'status',
        'results',
        'created_at',
        'updated_at',
        'backup_params',
        'filterable_id',
        'filterable_type',
    ]) }} as _airbyte_filters_hashid,
    tmp.*
from {{ ref('filters_ab2') }} tmp
-- filters
where 1 = 1


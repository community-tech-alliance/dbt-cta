{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activist_code_counts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'turf_id',
        'activist_code_id',
        'count',
        'created_at',
        'id',
        'datecanvassed',
    ]) }} as _airbyte_activist_code_counts_hashid,
    tmp.*
from {{ ref('activist_code_counts_ab2') }} tmp
-- activist_code_counts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


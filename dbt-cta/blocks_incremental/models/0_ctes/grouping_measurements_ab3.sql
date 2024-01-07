{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('grouping_measurements_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'measurable_id',
        'grouping_id',
        'id',
        'position',
        'measurable_type',
    ]) }} as _airbyte_grouping_measurements_hashid,
    tmp.*
from {{ ref('grouping_measurements_ab2') }} as tmp
-- grouping_measurements
where 1 = 1

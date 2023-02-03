{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('core_field_syndications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'group_id',
        'hierarchy',
        'created_at',
        'updated_at',
        'source_group_id',
    ]) }} as _airbyte_core_field_syndications_hashid,
    tmp.*
from {{ ref('core_field_syndications_ab2') }} tmp
-- core_field_syndications
where 1 = 1


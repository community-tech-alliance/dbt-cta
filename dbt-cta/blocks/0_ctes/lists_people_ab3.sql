{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_people_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'list_id',
        'person_id',
    ]) }} as _airbyte_lists_people_hashid,
    tmp.*
from {{ ref('lists_people_ab2') }} tmp
-- lists_people
where 1 = 1


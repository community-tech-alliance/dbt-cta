{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('denominations_people_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'denomination_id',
        'person_id',
        'denominmemberable_type',
    ]) }} as _airbyte_denominations_people_hashid,
    tmp.*
from {{ ref('denominations_people_ab2') }} tmp
-- denominations_people
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_numbers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'ext',
        'dw_id',
        'number',
        'source',
        'status',
        'owner_id',
        'created_at',
        'owner_type',
        'updated_at',
        'interact_id',
        'number_type',
        'created_by_id',
        'updated_by_id',
    ]) }} as _airbyte_phone_numbers_hashid,
    tmp.*
from {{ ref('phone_numbers_ab2') }} tmp
-- phone_numbers
where 1 = 1


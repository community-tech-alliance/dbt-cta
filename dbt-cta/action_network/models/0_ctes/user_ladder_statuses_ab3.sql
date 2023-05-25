{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_ladder_statuses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'rung_id',
        'step_id',
        'user_id',
        'ladder_id',
        'wait_time',
        'created_at',
        'extra_data',
        'updated_at',
    ]) }} as _airbyte_user_ladder_statuses_hashid,
    tmp.*
from {{ ref('user_ladder_statuses_ab2') }} tmp
-- user_ladder_statuses
where 1 = 1


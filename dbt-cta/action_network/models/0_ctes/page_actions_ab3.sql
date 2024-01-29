{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_actions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
        'page_wrapper_id',
    ]) }} as _airbyte_page_actions_hashid,
    tmp.*
from {{ ref('page_actions_ab2') }} as tmp
-- page_actions
where 1 = 1

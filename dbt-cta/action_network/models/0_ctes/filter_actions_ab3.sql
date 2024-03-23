{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('filter_actions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'group_id',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
        'network_group_id',
    ]) }} as _airbyte_filter_actions_hashid,
    tmp.*
from {{ ref('filter_actions_ab2') }} as tmp
-- filter_actions
where 1 = 1

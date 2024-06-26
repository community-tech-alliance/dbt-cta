{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_change_logs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'owner_id',
        'new_phone',
        'old_phone',
        'created_at',
        'owner_type',
        'updated_at',
        'source_action_id',
        'source_action_type',
    ]) }} as _airbyte_phone_change_logs_hashid,
    tmp.*
from {{ ref('phone_change_logs_ab2') }} as tmp
-- phone_change_logs
where 1 = 1

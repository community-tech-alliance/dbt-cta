{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sms_status_logs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'user_id',
        'group_id',
        'new_user',
        'processed',
        'created_at',
        'sms_opt_in',
        'updated_at',
        'subscriber_id',
        'subscription_id',
    ]) }} as _airbyte_sms_status_logs_hashid,
    tmp.*
from {{ ref('sms_status_logs_ab2') }} as tmp
-- sms_status_logs
where 1 = 1

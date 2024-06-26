{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sms_unsubscriptions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'reason',
        'user_id',
        'owner_id',
        'processed',
        'source_id',
        'created_at',
        'owner_type',
        'updated_at',
        'source_type',
        'mobile_message_stat_id',
    ]) }} as _airbyte_sms_unsubscriptions_hashid,
    tmp.*
from {{ ref('sms_unsubscriptions_ab2') }} as tmp
-- sms_unsubscriptions
where 1 = 1

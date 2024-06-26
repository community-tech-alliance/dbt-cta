{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('webhook_messages_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'error',
        'user_id',
        'attempts',
        'group_id',
        'created_at',
        'extra_data',
        'trigger_id',
        'updated_at',
        'webhook_id',
        'error_message',
    ]) }} as _airbyte_webhook_messages_hashid,
    tmp.*
from {{ ref('webhook_messages_ab2') }} as tmp
-- webhook_messages
where 1 = 1

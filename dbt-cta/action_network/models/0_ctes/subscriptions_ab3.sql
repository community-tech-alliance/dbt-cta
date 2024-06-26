{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscriptions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'amount',
        'status',
        'user_id',
        'group_id',
        'new_user',
        'processed',
        'created_at',
        'salesforce',
        'updated_at',
        'source_code',
        'http_referer',
        'custom_fields',
        'salesforce_id',
        'subscriber_id',
        'user_action_id',
        'network_group_id',
        'source_action_id',
        'source_action_type',
    ]) }} as _airbyte_subscriptions_hashid,
    tmp.*
from {{ ref('subscriptions_ab2') }} as tmp
-- subscriptions
where 1 = 1

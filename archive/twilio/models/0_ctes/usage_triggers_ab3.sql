{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('usage_triggers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'recurring',
        'date_fired',
        'trigger_by',
        'account_sid',
        'api_version',
        'callback_url',
        'date_created',
        'date_updated',
        'current_value',
        'friendly_name',
        'trigger_value',
        'usage_category',
        'callback_method',
        'usage_record_uri',
    ]) }} as _airbyte_usage_triggers_hashid,
    tmp.*
from {{ ref('usage_triggers_ab2') }} as tmp
-- usage_triggers
where 1 = 1

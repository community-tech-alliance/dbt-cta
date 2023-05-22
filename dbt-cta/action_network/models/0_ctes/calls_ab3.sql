{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('calls_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'uuid',
        'email',
        'phone',
        'state',
        'status',
        'street',
        'country',
        'user_id',
        'tag_list',
        'zip_code',
        'last_name',
        'created_at',
        'first_name',
        'updated_at',
        'display_name',
        'custom_fields',
        'twilio_call_sid',
        'call_campaign_id',
        'originating_system',
    ]) }} as _airbyte_calls_hashid,
    tmp.*
from {{ ref('calls_ab2') }} tmp
-- calls
where 1 = 1


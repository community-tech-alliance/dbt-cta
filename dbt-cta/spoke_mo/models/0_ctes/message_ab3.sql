{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('message_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('is_from_contact'),
        'campaign_contact_id',
        'queued_at',
        'created_at',
        'media',
        'send_before',
        'contact_number',
        'user_number',
        'sent_at',
        'assignment_id',
        'user_id',
        'service',
        'service_id',
        'send_status',
        'messageservice_sid',
        'error_code',
        'id',
        'text',
        'service_response_at',
    ]) }} as _airbyte_message_hashid,
    tmp.*
from {{ ref('message_ab2') }} tmp
-- message
where 1 = 1



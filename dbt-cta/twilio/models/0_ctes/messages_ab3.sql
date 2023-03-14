{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('messages_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('to'),
        'sid',
        'uri',
        'body',
        adapter.quote('from'),
        'price',
        'status',
        'date_sent',
        'direction',
        'num_media',
        'error_code',
        'price_unit',
        'account_sid',
        'api_version',
        'date_created',
        'date_updated',
        'num_segments',
        'error_message',
        object_to_string('subresource_uris'),
        'messaging_service_sid',
    ]) }} as _airbyte_messages_hashid,
    tmp.*
from {{ ref('messages_ab2') }} tmp
-- messages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


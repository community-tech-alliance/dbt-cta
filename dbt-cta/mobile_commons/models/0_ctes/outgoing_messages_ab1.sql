{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'outgoing_messages') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    mms,
    body,
    type,
    status,
    profile,
    cast(sent_at as {{ dbt.type_timestamp() }}) as sent_at,
    campaign,
    multipart,
    previous_id,
    phone_number,
    message_template_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'mms',
    'body',
    'type',
    'status',
    'profile',
    'sent_at',
    'multipart',
    'phone_number',
    'message_template_id'
    ]) }} as _airbyte_outgoing_messages_hashid
from {{ source('cta', 'outgoing_messages') }}

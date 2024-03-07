{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'incoming_messages') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    mms,
    body,
    type,
    keyword,
    next_id,
    profile,
    campaign,
    multipart,
    cast(received_at as {{dbt.type_timestamp()}}) as received_at,
    carrier_name,
    phone_number,
    message_template_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'mms',
    'body',
    'type',
    'profile',
    'multipart',
    'received_at',
    'carrier_name',
    'phone_number',
    'message_template_id'
    ]) }} as _airbyte_incoming_messages_hashid
from {{ source('cta', 'incoming_messages') }}

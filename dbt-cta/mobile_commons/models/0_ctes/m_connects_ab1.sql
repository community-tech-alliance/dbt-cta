{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'm_connects') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    tags,
    active,
    autoroute,
    call_type,
    shortcode,
    voicemail,
    transcribe,
    voip_number,
    call_timeout,
    crm_alert_id,
    failover_text,
    failover_number,
    destination_number,
    subscriber_follow_up,
    destination_description,
    nonsubscriber_follow_up,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'active',
    'autoroute',
    'call_type',
    'shortcode',
    'voicemail',
    'transcribe',
    'voip_number',
    'call_timeout',
    'crm_alert_id',
    'failover_text',
    'failover_number',
    'destination_number',
    'subscriber_follow_up',
    'destination_description',
    'nonsubscriber_follow_up'
    ]) }} as _airbyte_m_connects_hashid
from {{ source('cta', 'm_connects') }}


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'sent_emails') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   body,
   from,
   list_id,
   subject,
   team_id,
   event_id,
   sender_id,
   created_at,
   recipients_count,
   email_template_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'body',
    'from',
    'list_id',
    'subject',
    'team_id',
    'event_id',
    'sender_id',
    'recipients_count',
    'email_template_id'
    ]) }} as _airbyte_sent_emails_hashid
from {{ source('cta', 'sent_emails') }}
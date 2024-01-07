
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
   recipients_count,
   event_id,
   list_id,
   email_template_id,
   subject,
   created_at,
   from,
   id,
   team_id,
   body,
   sender_id,
   {{ dbt_utils.surrogate_key([
     'recipients_count',
    'event_id',
    'list_id',
    'email_template_id',
    'subject',
    'from',
    'id',
    'team_id',
    'body',
    'sender_id'
    ]) }} as _airbyte_sent_emails_hashid
from {{ source('cta', 'sent_emails') }}
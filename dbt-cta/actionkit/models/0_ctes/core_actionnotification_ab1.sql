{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_actionnotification') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   'to',
   body,
   name,
   notes,
   hidden,
   subject,
   reply_to,
   created_at,
   updated_at,
   wrapper_id,
   custom_from,
   from_line_id
from {{ source('cta', 'core_actionnotification') }}

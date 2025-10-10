{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'spam_spamchecklog') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   why,
   check,
   reversed,
   action_id,
   created_at,
   updated_at,
   reversed_at,
   whitelisted,
   action_status,
   action_updated_at
from {{ source('cta', 'spam_spamchecklog') }}


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_sessions') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   user_id,
   created_at,
   updated_at,
   completed_at,
   phone_bank_id,
   caller_survey_response,
   {{ dbt_utils.surrogate_key([
     'id',
    'user_id',
    'phone_bank_id',
    'caller_survey_response'
    ]) }} as _airbyte_phone_banking_sessions_hashid
from {{ source('cta', 'phone_banking_sessions') }}
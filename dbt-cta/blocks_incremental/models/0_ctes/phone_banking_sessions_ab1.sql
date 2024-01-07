
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
   completed_at,
   phone_bank_id,
   updated_at,
   user_id,
   created_at,
   id,
   caller_survey_response,
   {{ dbt_utils.surrogate_key([
     'phone_bank_id',
    'user_id',
    'id',
    'caller_survey_response'
    ]) }} as _airbyte_phone_banking_sessions_hashid
from {{ source('cta', 'phone_banking_sessions') }}
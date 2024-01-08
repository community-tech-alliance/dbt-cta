{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_responses') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    answer_option_id,
    updated_at,
    created_at,
    id,
    question_id,
    call_id,
    open_ended_answer_text,
   {{ dbt_utils.surrogate_key([
     'answer_option_id',
    'id',
    'question_id',
    'call_id',
    'open_ended_answer_text'
    ]) }} as _airbyte_phone_banking_responses_hashid
from {{ source('cta', 'phone_banking_responses') }}

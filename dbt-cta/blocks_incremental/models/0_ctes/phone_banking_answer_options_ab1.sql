{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_answer_options') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    extras,
    response,
    created_at,
    updated_at,
    question_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'extras',
    'response',
    'question_id'
    ]) }} as _airbyte_phone_banking_answer_options_hashid
from {{ source('cta', 'phone_banking_answer_options') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_questions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    question_to_ask,
    updated_at,
    name,
    extras,
    created_at,
    id,
    type,
    created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'question_to_ask',
    'name',
    'extras',
    'id',
    'type',
    'created_by_user_id'
    ]) }} as _airbyte_phone_banking_questions_hashid
from {{ source('cta', 'phone_banking_questions') }}

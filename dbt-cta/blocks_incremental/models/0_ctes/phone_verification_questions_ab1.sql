{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_verification_questions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    question,
    updated_at,
    active,
    created_at,
    id,
   {{ dbt_utils.surrogate_key([
     'question',
    'active',
    'id'
    ]) }} as _airbyte_phone_verification_questions_hashid
from {{ source('cta', 'phone_verification_questions') }}

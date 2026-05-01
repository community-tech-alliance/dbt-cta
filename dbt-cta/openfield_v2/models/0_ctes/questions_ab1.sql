-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_questions') }}

select
    id,
    campaign_id,
    name,
    question_text,
    question_type,
    question_type_description,
    allow_multiple_choices,
    created_at,
    created_by_id,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _questions_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_questions') }}

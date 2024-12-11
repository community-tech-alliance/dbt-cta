select
    _airbyte_extracted_at,
    _airbyte_ctas_hashid,
    surveyQuestionVanId,
    values,
    options,
    text,
    type,
    key,
    _airbyte_questions_hashid
from {{ source('cta','ctas_questions_base') }}

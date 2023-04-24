select
    surveyQuestionVanId,
    values,
    options,
    text,
    type,
    key,
from {{ source('cta','ctas_questions_base') }}
select
    surveyQuestionVanId,
    values,
    options,
    text,
    type,
    key,
from {{ ref('ctas_questions_base') }}
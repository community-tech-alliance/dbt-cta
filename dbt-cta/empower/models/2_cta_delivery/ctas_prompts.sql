select
    _airbyte_extracted_at,
    _airbyte_ctas_hashid,
    ctaId,
    vanId,
    isDeleted,
    ordering,
    answers,
    answerInputType,
    id,
    promptText,
    dependsOnInitialDispositionResponse,
    _airbyte_prompts_hashid
from {{ source('cta','ctas_prompts_base') }}

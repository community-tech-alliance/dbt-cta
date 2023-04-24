select
    profileEid,
    ctaId,
    notes,
    contactedMts,
    answers,
    answerIdsByPromptId,
from {{ ref('ctaResults_base') }}
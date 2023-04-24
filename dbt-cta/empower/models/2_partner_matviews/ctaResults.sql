select
    profileEid,
    ctaId,
    notes,
    contactedMts,
    answers,
    answerIdsByPromptId,
from {{ source('cta','ctaResults_base') }}
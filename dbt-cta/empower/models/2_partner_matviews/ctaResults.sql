select
    profileEid,
    ctaId,
    notes,
    contactedMts,
    answers,
    answerIdsByPromptId,
    _airbyte_ctaResults_hashid
from {{ source('cta','ctaResults_base') }}
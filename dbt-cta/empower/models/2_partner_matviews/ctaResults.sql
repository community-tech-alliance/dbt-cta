select
    profileEid,
    ctaId,
    notes,
    contactedMts,
    answers,
    answeridsbypromptid,
from {{ source('cta','ctaresults_base') }}
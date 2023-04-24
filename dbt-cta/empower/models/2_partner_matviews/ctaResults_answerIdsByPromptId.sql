select
    *
from {{ source('cta','ctaresults_answeridsbypromptid_base') }}
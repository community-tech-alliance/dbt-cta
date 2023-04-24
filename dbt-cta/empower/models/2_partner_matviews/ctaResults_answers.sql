select
    *
from {{ source('cta','ctaresults_answers_base') }}
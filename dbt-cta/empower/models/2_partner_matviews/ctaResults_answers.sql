select
    _airbyte_ctaResults_hashid,
    _11,
    _1,
    _10,
    _airbyte_answers_hashid
from {{ source('cta','ctaResults_answers_base') }}
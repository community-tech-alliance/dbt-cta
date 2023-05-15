select
    _airbyte_emitted_at,
    _airbyte_ctaResults_hashid,
    _13805,
    _13198,
    _13683,
    _13197,
    _13684,
    _13800,
    _13303,
    _13304,
    _airbyte_answerIdsByPromptId_hashid
from {{ source('cta','ctaResults_answerIdsByPromptId_base') }}
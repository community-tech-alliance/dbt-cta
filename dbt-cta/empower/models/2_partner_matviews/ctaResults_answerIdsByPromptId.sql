SELECT
    *
EXCEPT (_airbyte_ab_id, _airbyte_emitted_at, _airbyte_normalized_at)
FROM {{ source('cta','ctaresults_answeridsbypromptid_base') }}
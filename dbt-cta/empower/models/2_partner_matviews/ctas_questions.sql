SELECT
    *
EXCEPT (_airbyte_ab_id, _airbyte_emitted_at, _airbyte_normalized_at)
FROM {{ source('cta','ctas_questions_base') }}
{{ config(
    unique_key = "answerId"
) }}

-- Final base SQL model
-- depends_on: {{ ref('survey_result_ab2') }}
select *
from {{ ref('survey_result_ab2') }}

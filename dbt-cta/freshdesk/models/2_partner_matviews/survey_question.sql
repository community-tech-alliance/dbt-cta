-- Final base SQL model
-- depends_on: {{ ref('survey_question_base') }}
select
  survey_id,
  id,
  accepted_ratings,
  label
from {{ source('cta', 'survey_question_base') }}
-- companies from {{ source('cta', 'survey_question_base') }}



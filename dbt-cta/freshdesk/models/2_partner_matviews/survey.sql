-- Final base SQL model
-- depends_on: {{ ref('survey_base') }}
select
  id,
  title,
  created_at,
  updated_at
from {{ ref('survey_base') }}
-- companies from {{ source('cta', 'survey_base') }}



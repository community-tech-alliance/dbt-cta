-- Final base SQL model
-- depends_on: {{ ref('survey_base') }}
select
  _airbyte_emitted_at,
  id,
  title,
  created_at,
  updated_at
from {{ source('cta', 'survey_base') }}
-- companies from {{ source('cta', 'survey_base') }}



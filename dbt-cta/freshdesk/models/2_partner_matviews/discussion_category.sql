-- Final base SQL model
-- depends_on: {{ ref('discussion_category_base') }}
select
  id,
  name,
  description,
  created_at,
  updated_at
from {{ source('cta', 'discussion_category_base') }}
-- companies from {{ source('cta', 'discussion_category_base') }}
-- Final base SQL model
-- depends_on: {{ ref('discussion_forum_base') }}
select
  id,
  name,
  description,
  position,
  forum_type,
  forum_visibility,
  topics_count,
  posts_count,
  discussion_category_id
from {{ source('cta', 'discussion_forum_base') }}
-- companies from {{ source('cta', 'discussion_forum_base') }}



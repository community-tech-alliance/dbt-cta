select *
from {{ source('cta', 'core_user_page_tags_base') }}

select *
from {{ source('cta', 'collections_roles_base') }}

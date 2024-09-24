select *
from {{ source('cta', 'contacts_list_memberships_base') }}

select *
from {{ source('cta', 'contacts_base') }}

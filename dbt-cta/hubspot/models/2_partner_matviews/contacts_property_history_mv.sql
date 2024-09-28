select *
from {{ source('cta', 'contacts_property_history_base') }}

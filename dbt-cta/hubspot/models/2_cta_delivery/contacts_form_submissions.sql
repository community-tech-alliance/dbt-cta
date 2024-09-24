select *
from {{ source('cta', 'contacts_form_submissions_base') }}

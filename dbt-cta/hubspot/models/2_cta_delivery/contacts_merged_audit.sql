select *
from {{ source('cta', 'contacts_merged_audit_base') }}
select *
from {{ source('cta','group_memberships_base') }}

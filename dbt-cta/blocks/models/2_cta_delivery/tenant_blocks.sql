select *
from {{ source('cta','tenant_blocks_base') }}

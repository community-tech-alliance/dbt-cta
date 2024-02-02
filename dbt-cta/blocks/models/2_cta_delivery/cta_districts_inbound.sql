select
    *
from {{ source('cta','districts_inbound_base') }}
select
    is_primary,
    user_id,
    service,
    id,
    cell,
    _airbyte_emitted_at,
    _airbyte_user_cell_hashid
from {{ source('cta','user_cell_base') }}
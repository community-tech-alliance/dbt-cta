select
    id,
    uuid,
    total,
    params,
    status,
    results,
    created_at,
    updated_at,
    backup_params,
    filterable_id,
    filterable_type,
    _airbyte_filters_hashid
from {{ source('cta','filters_base') }}
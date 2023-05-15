select
    _airbyte_emitted_at,
    id,
    ocdid_id,
    core_field_id
from {{ source('cta','core_fields_ocdids_base') }}
select
    id,
    ocdid_id,
    core_field_id,
    _airbyte_core_fields_ocdids_hashid
from {{ ref('core_fields_ocdids_base') }}
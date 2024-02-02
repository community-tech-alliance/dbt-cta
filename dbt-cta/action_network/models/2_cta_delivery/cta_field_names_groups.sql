select
    id,
    hidden,
    group_id,
    field_name_id,
    _airbyte_field_names_groups_hashid
from {{ source('cta','field_names_groups_base') }}

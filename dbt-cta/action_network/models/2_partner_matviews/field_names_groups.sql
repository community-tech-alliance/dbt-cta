select
    id,
    hidden,
    group_id,
    field_name_id
from {{ source('cta','field_names_groups_base') }}
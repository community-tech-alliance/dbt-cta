-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('group_members_ab2') }}
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(role as 
    string
), ''), '-', coalesce(cast(type as 
    string
), ''), '-', coalesce(cast(email as 
    string
), '')) as 
    string
))) as _airbyte_group_members_hashid,
    tmp.*
from {{ ref('group_members_ab2') }} tmp
where 1 = 1
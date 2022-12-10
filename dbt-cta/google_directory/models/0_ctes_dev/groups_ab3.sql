-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('groups_ab2') }}
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(etag as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(name as 
    string
), ''), '-', coalesce(cast(email as 
    string
), ''), '-', coalesce(cast(description as 
    string
), ''), '-', coalesce(cast(adminCreated as 
    string
), ''), '-', coalesce(cast(directMembersCount as 
    string
), '')) as 
    string
))) as _airbyte_groups_hashid,
    tmp.*
from {{ ref('groups_ab2') }} tmp
where 1 = 1
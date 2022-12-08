-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_organizations_ab2') }}
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as 
    string
), ''), '-', coalesce(cast(name as 
    string
), ''), '-', coalesce(cast(title as 
    string
), ''), '-', coalesce(cast(primary as 
    string
), ''), '-', coalesce(cast(customType as 
    string
), ''), '-', coalesce(cast(description as 
    string
), '')) as 
    string
))) as _airbyte_organizations_hashid,
    tmp.*
from {{ ref('users_organizations_ab2') }} tmp
where 1 = 1
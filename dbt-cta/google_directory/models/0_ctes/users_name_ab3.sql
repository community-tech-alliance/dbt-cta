-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_name_ab2') }}
select
    tmp.*,
    to_hex(md5(cast(
        concat(coalesce(cast(
            _airbyte_users_hashid as
            string
        ), ''), '-', coalesce(cast(
            fullName as
            string
        ), ''), '-', coalesce(cast(
            givenName as
            string
        ), ''), '-', coalesce(cast(
            familyName as
            string
        ), '')) as
        string
    ))) as _airbyte_name_hashid
from {{ ref('users_name_ab2') }} as tmp
where 1 = 1

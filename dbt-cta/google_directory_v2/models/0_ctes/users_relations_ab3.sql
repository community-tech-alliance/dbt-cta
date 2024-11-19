-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_relations_ab2') }}
select
    tmp.*,
    to_hex(md5(cast(
        concat(coalesce(cast(
            _airbyte_users_hashid as
            string
        ), ''), '-', coalesce(cast(
            type as
            string
        ), ''), '-', coalesce(cast(
            value as
            string
        ), ''), '-', coalesce(cast(
            customType as
            string
        ), '')) as
        string
    ))) as _airbyte_relations_hashid
from {{ ref('users_relations_ab2') }} as tmp
where 1 = 1

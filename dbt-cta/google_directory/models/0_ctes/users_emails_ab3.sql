-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_emails_ab2') }}
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as
    string
), ''), '-', coalesce(cast(type as
    string
), ''), '-', coalesce(cast(address as
    string
), ''), '-', coalesce(cast(primary as --noqa
    string
), ''), '-', coalesce(cast(customType as
    string
), '')) as
    string
))) as _airbyte_emails_hashid,
    tmp.*
from {{ ref('users_emails_ab2') }}
where 1 = 1

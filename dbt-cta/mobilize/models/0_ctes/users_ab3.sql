{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("users_ab2")}}

select
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(given_name as string), ''),
                    '-',
                    coalesce(cast(family_name as string), ''),
                    '-',
                    coalesce(cast(postal_code as string), ''),
                    '-',
                    coalesce(cast(blocked_date as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(phone_number as string), ''),
                    '-',
                    coalesce(cast(email_address as string), ''),
                    '-',
                    coalesce(cast(membership_id as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), ''),
                    '-',
                    coalesce(cast(globally_blocked_date as string), ''),
                    '-',
                    coalesce(cast(membership__created_date as string), ''),
                    '-',
                    coalesce(cast(membership__modified_date as string), ''),
                    '-',
                    coalesce(cast(membership__organization_id as string), ''),
                    '-',
                    coalesce(cast(membership__permission_tier as string), '')
                ) as string
            )
        )
    ) as _airbyte_users_hashid,
    tmp.*
from {{ ref("users_ab2")}} tmp
-- users
where 1 = 1

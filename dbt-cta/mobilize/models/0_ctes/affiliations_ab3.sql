{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("affiliations_ab2") }}
select
    tmp.*,
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(source as string), ''),
                    '-',
                    coalesce(cast(user_id as string), ''),
                    '-',
                    coalesce(cast(blocked_date as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(deleted_date as string), ''),
                    '-',
                    coalesce(cast(user__region as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), ''),
                    '-',
                    coalesce(cast(user__locality as string), ''),
                    '-',
                    coalesce(cast(organization_id as string), ''),
                    '-',
                    coalesce(cast(user__given_name as string), ''),
                    '-',
                    coalesce(cast(user__family_name as string), ''),
                    '-',
                    coalesce(cast(user__postal_code as string), ''),
                    '-',
                    coalesce(cast(user__phone_number as string), ''),
                    '-',
                    coalesce(cast(user__email_address as string), ''),
                    '-',
                    coalesce(cast(user__modified_date as string), ''),
                    '-',
                    coalesce(cast(committed_to_host_date as string), ''),
                    '-',
                    coalesce(cast(host_commitment_source as string), ''),
                    '-',
                    coalesce(cast(user__globally_blocked_date as string), ''),
                    '-',
                    coalesce(cast(declined_to_commit_to_host_date as string), '')
                ) as string
            )
        )
    ) as _airbyte_affiliations_hashid
from {{ ref("affiliations_ab2") }} as tmp
-- affiliations
where 1 = 1

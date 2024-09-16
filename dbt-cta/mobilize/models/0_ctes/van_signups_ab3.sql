{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("van_signups_ab2") }}

select
    tmp.*,
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(van_id as string), ''),
                    '-',
                    coalesce(cast(user_id as string), ''),
                    '-',
                    coalesce(cast(signup_type as string), ''),
                    '-',
                    coalesce(cast(timeslot_id as string), ''),
                    '-',
                    coalesce(cast(committee_id as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), ''),
                    '-',
                    coalesce(cast(participation_id as string), ''),
                    '-',
                    coalesce(cast(van_event_van_id as string), ''),
                    '-',
                    coalesce(cast(van_shift_van_id as string), ''),
                    '-',
                    coalesce(cast(van_person_van_id as string), '')
                ) as string
            )
        )
    ) as _airbyte_van_signups_hashid
from {{ ref("van_signups_ab2") }} as tmp
-- van_signups
where 1 = 1

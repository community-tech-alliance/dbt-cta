{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("timeslots_ab2")}}

select
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(end_date as string), ''),
                    '-',
                    coalesce(cast(event_id as string), ''),
                    '-',
                    coalesce(cast(start_date as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(deleted_date as string), ''),
                    '-',
                    coalesce(cast(max_attendees as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), '')
                ) as string
            )
        )
    ) as _airbyte_timeslots_hashid,
    tmp.*
from {{ ref("timeslots_ab2")}} tmp
-- timeslots
where 1 = 1

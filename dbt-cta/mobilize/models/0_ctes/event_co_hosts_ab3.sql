{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("event_co_hosts_ab2") }}
select
    tmp.*,
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(email as string), ''),
                    '-',
                    coalesce(cast(user_id as string), ''),
                    '-',
                    coalesce(cast(event_id as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), '')
                ) as string
            )
        )
    ) as _airbyte_event_co_hosts_hashid
from {{ ref("event_co_hosts_ab2") }} as tmp
-- event_co_hosts
where 1 = 1

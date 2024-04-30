{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("van_persons_ab2")}}

select
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
                    coalesce(cast(committee_id as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), '')
                ) as string
            )
        )
    ) as _airbyte_van_persons_hashid,
    tmp.*
from {{ ref("van_persons_ab2")}} tmp
-- van_persons
where 1 = 1

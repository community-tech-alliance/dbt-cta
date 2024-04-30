{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("organizations_ab2")}}

select
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(name as string), ''),
                    '-',
                    coalesce(cast(slug as string), ''),
                    '-',
                    coalesce(cast(committee_id as string), '')
                ) as string
            )
        )
    ) as _airbyte_organizations_hashid,
    tmp.*
from {{ ref("organizations_ab2")}} tmp
-- organizations
where 1 = 1

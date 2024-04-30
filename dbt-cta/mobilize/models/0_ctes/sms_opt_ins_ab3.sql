{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("sms_opt_ins_ab2")}}

select
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(user_id as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), ''),
                    '-',
                    coalesce(cast(organization_id as string), ''),
                    '-',
                    coalesce(cast(sms_opt_in_status as string), ''),
                    '-',
                    coalesce(cast(user__phone_number as string), '')
                ) as string
            )
        )
    ) as _airbyte_sms_opt_ins_hashid,
    tmp.*
from {{ ref("sms_opt_ins_ab2")}} tmp
-- sms_opt_ins
where 1 = 1

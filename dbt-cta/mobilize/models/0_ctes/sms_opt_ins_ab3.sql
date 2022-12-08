
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_sms_opt_ins" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(
                _airbyte_data, "$['organization_id']"
            ) as organization_id,
            json_extract_scalar(
                _airbyte_data, "$['sms_opt_in_status']"
            ) as sms_opt_in_status,
            json_extract_scalar(
                _airbyte_data, "$['user__phone_number']"
            ) as user__phone_number,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_sms_opt_ins") }} as table_alias
        -- sms_opt_ins
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab1
        select
            cast(id as int64) as id,
            cast(user_id as int64) as user_id,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            cast(organization_id as int64) as organization_id,
            cast(sms_opt_in_status as string) as sms_opt_in_status,
            cast(user__phone_number as string) as user__phone_number,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab1
        -- sms_opt_ins
        where 1 = 1

    )  -- SQL model to build a hash column based on the values of this record
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab2
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
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_sms_opt_ins_ab2 tmp
-- sms_opt_ins
where 1 = 1

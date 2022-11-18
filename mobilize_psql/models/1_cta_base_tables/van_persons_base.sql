
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_van_persons" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
            json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
            json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_van_persons") }} as table_alias
        -- van_persons
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab1
        select
            cast(id as int64) as id,
            cast(van_id as int64) as van_id,
            cast(user_id as int64) as user_id,
            cast(committee_id as int64) as committee_id,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab1
        -- van_persons
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab2
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
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab2 tmp
        -- van_persons
        where 1 = 1

    )  -- Final base SQL model
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab3
select
    id,
    van_id,
    user_id,
    committee_id,
    created_date,
    modified_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_van_persons_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_persons_ab3
-- van_persons from {{ source("cta", "_airbyte_raw_van_persons" ) }}
where
    1 = 1


    and cast(_airbyte_emitted_at as timestamp)
    >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)

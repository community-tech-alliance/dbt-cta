
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_van_signups" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
            json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
            json_extract_scalar(_airbyte_data, "$['signup_type']") as signup_type,
            json_extract_scalar(_airbyte_data, "$['timeslot_id']") as timeslot_id,
            json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(
                _airbyte_data, "$['participation_id']"
            ) as participation_id,
            json_extract_scalar(
                _airbyte_data, "$['van_event_van_id']"
            ) as van_event_van_id,
            json_extract_scalar(
                _airbyte_data, "$['van_shift_van_id']"
            ) as van_shift_van_id,
            json_extract_scalar(
                _airbyte_data, "$['van_person_van_id']"
            ) as van_person_van_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_van_signups") }} as table_alias
        -- van_signups
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab1
        select
            cast(id as int64) as id,
            cast(van_id as int64) as van_id,
            cast(user_id as int64) as user_id,
            cast(signup_type as string) as signup_type,
            cast(timeslot_id as int64) as timeslot_id,
            cast(committee_id as int64) as committee_id,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            cast(participation_id as int64) as participation_id,
            cast(van_event_van_id as int64) as van_event_van_id,
            cast(van_shift_van_id as int64) as van_shift_van_id,
            cast(van_person_van_id as int64) as van_person_van_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab1
        -- van_signups
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab2
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
            ) as _airbyte_van_signups_hashid,
            tmp.*
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab2 tmp
        -- van_signups
        where 1 = 1

    )  -- Final base SQL model
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab3
select
    id,
    van_id,
    user_id,
    signup_type,
    timeslot_id,
    committee_id,
    created_date,
    modified_date,
    participation_id,
    van_event_van_id,
    van_shift_van_id,
    van_person_van_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_van_signups_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_signups_ab3
-- van_signups from {{ source("cta", "_airbyte_raw_van_signups" ) }}
where
    1 = 1


    and cast(_airbyte_emitted_at as timestamp)
    >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)

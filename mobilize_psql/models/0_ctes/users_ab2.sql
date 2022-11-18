
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_users" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['given_name']") as given_name,
            json_extract_scalar(_airbyte_data, "$['family_name']") as family_name,
            json_extract_scalar(_airbyte_data, "$['postal_code']") as postal_code,
            json_extract_scalar(_airbyte_data, "$['blocked_date']") as blocked_date,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['phone_number']") as phone_number,
            json_extract_scalar(_airbyte_data, "$['email_address']") as email_address,
            json_extract_scalar(_airbyte_data, "$['membership_id']") as membership_id,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(
                _airbyte_data, "$['globally_blocked_date']"
            ) as globally_blocked_date,
            json_extract_scalar(
                _airbyte_data, "$['membership__created_date']"
            ) as membership__created_date,
            json_extract_scalar(
                _airbyte_data, "$['membership__modified_date']"
            ) as membership__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['membership__organization_id']"
            ) as membership__organization_id,
            json_extract_scalar(
                _airbyte_data, "$['membership__permission_tier']"
            ) as membership__permission_tier,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_users") }} as table_alias
        -- users
        where 1 = 1

    -- SQL model to cast each column to its adequate SQL type converted from the JSON
    -- schema type
    )
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab1
select
    cast(id as int64) as id,
    cast(given_name as string) as given_name,
    cast(family_name as string) as family_name,
    cast(postal_code as string) as postal_code,
    cast(nullif(blocked_date, '') as timestamp) as blocked_date,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(phone_number as string) as phone_number,
    cast(email_address as string) as email_address,
    cast(membership_id as int64) as membership_id,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    cast(nullif(globally_blocked_date, '') as timestamp) as globally_blocked_date,
    cast(nullif(membership__created_date, '') as timestamp) as membership__created_date,
    cast(
        nullif(membership__modified_date, '') as timestamp
    ) as membership__modified_date,
    cast(membership__organization_id as int64) as membership__organization_id,
    cast(membership__permission_tier as string) as membership__permission_tier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab1
-- users
where 1 = 1

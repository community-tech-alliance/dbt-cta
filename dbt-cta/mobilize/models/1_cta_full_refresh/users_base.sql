{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

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

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab1
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
            cast(
                nullif(globally_blocked_date, '') as timestamp
            ) as globally_blocked_date,
            cast(
                nullif(membership__created_date, '') as timestamp
            ) as membership__created_date,
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

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(given_name as string), ''),
                            '-',
                            coalesce(cast(family_name as string), ''),
                            '-',
                            coalesce(cast(postal_code as string), ''),
                            '-',
                            coalesce(cast(blocked_date as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(phone_number as string), ''),
                            '-',
                            coalesce(cast(email_address as string), ''),
                            '-',
                            coalesce(cast(membership_id as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), ''),
                            '-',
                            coalesce(cast(globally_blocked_date as string), ''),
                            '-',
                            coalesce(cast(membership__created_date as string), ''),
                            '-',
                            coalesce(cast(membership__modified_date as string), ''),
                            '-',
                            coalesce(cast(membership__organization_id as string), ''),
                            '-',
                            coalesce(cast(membership__permission_tier as string), '')
                        ) as string
                    )
                )
            ) as _airbyte_users_hashid,
            tmp.*
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab2 tmp
        -- users
        where 1 = 1

    )  -- Final base SQL model
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab3
select
    id,
    given_name,
    family_name,
    postal_code,
    blocked_date,
    created_date,
    phone_number,
    email_address,
    membership_id,
    modified_date,
    globally_blocked_date,
    membership__created_date,
    membership__modified_date,
    membership__organization_id,
    membership__permission_tier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_users_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_users_ab3
-- users from {{ source("cta", "_airbyte_raw_users" ) }}
-- where
--     1 = 1


--     and cast(_airbyte_emitted_at as timestamp)
--     >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

-- before edits: 14 records in base, 14 in partner
-- after adding prefix/suffix: 
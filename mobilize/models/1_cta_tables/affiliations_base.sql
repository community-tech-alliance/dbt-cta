
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_affiliations" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['source']") as source,
            json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
            json_extract_scalar(_airbyte_data, "$['blocked_date']") as blocked_date,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['deleted_date']") as deleted_date,
            json_extract_scalar(_airbyte_data, "$['user__region']") as user__region,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(_airbyte_data, "$['user__locality']") as user__locality,
            json_extract_scalar(
                _airbyte_data, "$['organization_id']"
            ) as organization_id,
            json_extract_scalar(
                _airbyte_data, "$['user__given_name']"
            ) as user__given_name,
            json_extract_scalar(
                _airbyte_data, "$['user__family_name']"
            ) as user__family_name,
            json_extract_scalar(
                _airbyte_data, "$['user__postal_code']"
            ) as user__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['user__phone_number']"
            ) as user__phone_number,
            json_extract_scalar(
                _airbyte_data, "$['user__email_address']"
            ) as user__email_address,
            json_extract_scalar(
                _airbyte_data, "$['user__modified_date']"
            ) as user__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['committed_to_host_date']"
            ) as committed_to_host_date,
            json_extract_scalar(
                _airbyte_data, "$['host_commitment_source']"
            ) as host_commitment_source,
            json_extract_scalar(
                _airbyte_data, "$['user__globally_blocked_date']"
            ) as user__globally_blocked_date,
            json_extract_scalar(
                _airbyte_data, "$['declined_to_commit_to_host_date']"
            ) as declined_to_commit_to_host_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_affiliations") }} as table_alias
        -- affiliations
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab1
        select
            cast(id as int64) as id,
            cast(source as string) as source,
            cast(user_id as int64) as user_id,
            cast(nullif(blocked_date, '') as timestamp) as blocked_date,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(deleted_date, '') as timestamp) as deleted_date,
            cast(user__region as string) as user__region,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            cast(user__locality as string) as user__locality,
            cast(organization_id as int64) as organization_id,
            cast(user__given_name as string) as user__given_name,
            cast(user__family_name as string) as user__family_name,
            cast(user__postal_code as string) as user__postal_code,
            cast(user__phone_number as string) as user__phone_number,
            cast(user__email_address as string) as user__email_address,
            cast(nullif(user__modified_date, '') as timestamp) as user__modified_date,
            cast(
                nullif(committed_to_host_date, '') as timestamp
            ) as committed_to_host_date,
            cast(host_commitment_source as string) as host_commitment_source,
            cast(
                nullif(user__globally_blocked_date, '') as timestamp
            ) as user__globally_blocked_date,
            cast(
                nullif(declined_to_commit_to_host_date, '') as timestamp
            ) as declined_to_commit_to_host_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab1
        -- affiliations
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(source as string), ''),
                            '-',
                            coalesce(cast(user_id as string), ''),
                            '-',
                            coalesce(cast(blocked_date as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(deleted_date as string), ''),
                            '-',
                            coalesce(cast(user__region as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), ''),
                            '-',
                            coalesce(cast(user__locality as string), ''),
                            '-',
                            coalesce(cast(organization_id as string), ''),
                            '-',
                            coalesce(cast(user__given_name as string), ''),
                            '-',
                            coalesce(cast(user__family_name as string), ''),
                            '-',
                            coalesce(cast(user__postal_code as string), ''),
                            '-',
                            coalesce(cast(user__phone_number as string), ''),
                            '-',
                            coalesce(cast(user__email_address as string), ''),
                            '-',
                            coalesce(cast(user__modified_date as string), ''),
                            '-',
                            coalesce(cast(committed_to_host_date as string), ''),
                            '-',
                            coalesce(cast(host_commitment_source as string), ''),
                            '-',
                            coalesce(cast(user__globally_blocked_date as string), ''),
                            '-',
                            coalesce(
                                cast(declined_to_commit_to_host_date as string), ''
                            )
                        ) as string
                    )
                )
            ) as _airbyte_affiliations_hashid,
            tmp.*
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab2 tmp
        -- affiliations
        where 1 = 1

    )  -- Final base SQL model
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab3
select
    id,
    source,
    user_id,
    blocked_date,
    created_date,
    deleted_date,
    user__region,
    modified_date,
    user__locality,
    organization_id,
    user__given_name,
    user__family_name,
    user__postal_code,
    user__phone_number,
    user__email_address,
    user__modified_date,
    committed_to_host_date,
    host_commitment_source,
    user__globally_blocked_date,
    declined_to_commit_to_host_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_affiliations_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_affiliations_ab3
-- affiliations from {{ source("cta", "_airbyte_raw_affiliations" ) }}
where
    1 = 1


    and cast(_airbyte_emitted_at as timestamp)
    >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)


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

    -- SQL model to cast each column to its adequate SQL type converted from the JSON
    -- schema type
    )
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
    cast(nullif(committed_to_host_date, '') as timestamp) as committed_to_host_date,
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

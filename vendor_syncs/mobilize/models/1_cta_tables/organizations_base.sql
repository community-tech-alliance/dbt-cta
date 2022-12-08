
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_organizations" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['name']") as name,
            json_extract_scalar(_airbyte_data, "$['slug']") as slug,
            json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_organizations") }} as table_alias
        -- organizations
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab1
        select
            cast(id as int64) as id,
            cast(name as string) as name,
            cast(slug as string) as slug,
            cast(committee_id as int64) as committee_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab1
        -- organizations
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab2
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
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab2 tmp
        -- organizations
        where 1 = 1

    )  -- Final base SQL model
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab3
select
    id,
    name,
    slug,
    committee_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_organizations_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_organizations_ab3
-- organizations from {{ source("cta", "_airbyte_raw_organizations" ) }}
where
    1 = 1


    and cast(_airbyte_emitted_at as timestamp)
    >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)

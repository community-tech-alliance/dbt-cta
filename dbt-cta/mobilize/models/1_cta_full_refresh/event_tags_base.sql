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
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_event_tags" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['tag_id']") as tag_id,
            json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
            json_extract_scalar(_airbyte_data, "$['tag__name']") as tag__name,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['deleted_date']") as deleted_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_event_tags") }} as table_alias
        -- event_tags
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab1
        select
            cast(id as int64) as id,
            cast(tag_id as int64) as tag_id,
            cast(event_id as int64) as event_id,
            cast(tag__name as string) as tag__name,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(deleted_date, '') as timestamp) as deleted_date,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab1
        -- event_tags
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(tag_id as string), ''),
                            '-',
                            coalesce(cast(event_id as string), ''),
                            '-',
                            coalesce(cast(tag__name as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(deleted_date as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), '')
                        ) as string
                    )
                )
            ) as _airbyte_event_tags_hashid,
            tmp.*
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab2 tmp
        -- event_tags
        where 1 = 1

    )  -- Final base SQL model
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab3
select
    id,
    tag_id,
    event_id,
    tag__name,
    created_date,
    deleted_date,
    modified_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_event_tags_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_tags_ab3
-- event_tags from {{ source("cta", "_airbyte_raw_event_tags" ) }}
where 1 = 1
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

-- before edits: 276 records in base, 276 in partner
-- after adding prefix/suffix: error
--  Cannot replace a table with a different partitioning spec. Instead, DROP the table, and then recreate it. New partitioning spec is interval(type:day,field:_airbyte_emitted_at) clustering(_airbyte_emitted_at) and existing spec is none


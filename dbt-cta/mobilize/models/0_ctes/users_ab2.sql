{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("users_ab1") }}

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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("users_ab1") }}
-- users
where 1 = 1

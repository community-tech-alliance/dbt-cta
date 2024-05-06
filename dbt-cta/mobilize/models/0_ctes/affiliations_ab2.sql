{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- depends_on: {{ ref("affiliations_ab1") }}

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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("affiliations_ab1") }}
-- affiliations
where 1 = 1

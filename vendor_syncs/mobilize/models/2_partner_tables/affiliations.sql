{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_affiliations_hashid",
    )
}}

-- depends_on: {{ source('cta', 'affiliations_base') }}
select
    _airbyte_affiliations_hashid,
    max(id) as id,
    max(source) as source,
    max(user_id) as user_id,
    max(blocked_date) as blocked_date,
    max(created_date) as created_date,
    max(deleted_date) as deleted_date,
    max(user__region) as user__region,
    max(modified_date) as modified_date,
    max(user__locality) as user__locality,
    max(organization_id) as organization_id,
    max(user__given_name) as user__given_name,
    max(user__family_name) as user__family_name,
    max(user__postal_code) as user__postal_code,
    max(user__phone_number) as user__phone_number,
    max(user__email_address) as user__email_address,
    max(user__modified_date) as user__modified_date,
    max(committed_to_host_date) as comitted_to_host_date,
    max(host_commitment_source) as host_commitment_source,
    max(user__globally_blocked_date) as user__globally_blocked_date,
    max(declined_to_commit_to_host_date) as declined_to_commit_to_host_date,
    max(_airbyte_ab_id) as _airbyte_ab_id,
    max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "affiliations_base") }}
group by _airbyte_affiliations_hashid

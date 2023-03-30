{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_users_hashid",
    )
}}

-- depends_on: {{ source('cta', 'users_base') }}
select
    _airbyte_users_hashid,
    max(id) as id,
    max(given_name) as given_name,
    max(family_name) as family_name,
    max(postal_code) as postal_code,
    max(blocked_date) as blocked_date,
    max(created_date) as created_date,
    max(phone_number) as phone_number,
    max(email_address) as email_address,
    max(membership_id) as membership_id,
    max(modified_date) as modified_date,
    max(globally_blocked_date) as globally_blocked_date,
    max(membership__created_date) as membership__created_date,
    max(membership__modified_date) as membership__modified_date,
    max(membership__organization_id) as membership__organization_id,
    max(membership__permission_tier) as membership__permission_tier,
    max(_airbyte_ab_id) as _airbyte_ab_id,
    max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "users_base") }}
group by _airbyte_users_hashid
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
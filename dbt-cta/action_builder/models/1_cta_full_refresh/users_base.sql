{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    id,
    uid,
    role,
    email,
    tokens,
    provider,
    last_name,
    api_access,
    created_at,
    deleted_at,
    disable_on,
    first_name,
    updated_at,
    confirmed_at,
    phone_number,
    invited_by_id,
    sign_in_count,
    invited_by_type,
    last_sign_in_at,
    last_sign_in_ip,
    invitation_limit,
    invitation_token,
    invitations_count,
    unconfirmed_email,
    confirmation_token,
    current_sign_in_at,
    current_sign_in_ip,
    encrypted_password,
    invitation_sent_at,
    remember_created_at,
    authentication_token,
    confirmation_sent_at,
    reset_password_token,
    allow_password_change,
    invitation_created_at,
    invitation_accepted_at,
    reset_password_sent_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('cta', '_airbyte_raw_users') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
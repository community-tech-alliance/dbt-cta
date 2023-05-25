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
    info,
    role,
    uuid,
    agree,
    email,
    stats,
    language,
    auth_hash,
    permalink,
    created_at,
    deleted_at,
    updated_at,
    confirmed_at,
    lists_enabled,
    root_group_id,
    sign_in_count,
    is_super_admin,
    last_sign_in_at,
    last_sign_in_ip,
    avatar_file_name,
    avatar_file_size,
    save_credit_card,
    redirects_enabled,
    unconfirmed_email,
    current_sign_in_at,
    current_sign_in_ip,
    originating_system,
    avatar_content_type,
    enable_applications,
    remember_created_at,
    confirmation_sent_at,
    custom_fields_enabled,
    reset_password_sent_at,
    salesforce_last_update,
    current_page_wrapper_id,
    email_templates_enabled,
    salesforce_sync_enabled,
    salesforce_custom_fields,
    credit_card_last_4_digits,
    current_email_template_id,
    salesforce_sync_successful,
    receive_transactional_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('cta', '_airbyte_raw_users') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
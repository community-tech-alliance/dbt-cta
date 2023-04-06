{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('emails_ab3') }}
select
    id,
    {{ adapter.quote('to') }},
    body,
    {{ adapter.quote('from') }},
    uuid,
    stats,
    hidden,
    status,
    subject,
    user_id,
    group_id,
    reply_to,
    tag_list,
    permalink,
    send_date,
    timezones,
    created_at,
    is_sending,
    pre_header,
    total_sent,
    updated_at,
    finish_send,
    builder_html,
    builder_json,
    button_color,
    delivered_at,
    actions_count,
    target_option,
    typeface_color,
    first_permalink,
    inlined_content,
    parent_email_id,
    button_text_color,
    email_template_id,
    administrative_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_emails_hashid
from {{ ref('emails_ab3') }}
-- emails from {{ source('cta', '_airbyte_raw_emails') }}
where 1 = 1


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
    _airbyte_emails_hashid
from {{ source('cta','emails_base') }}

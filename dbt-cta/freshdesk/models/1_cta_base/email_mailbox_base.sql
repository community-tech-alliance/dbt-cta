{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_mailbox_ab3') }}
select
    id,
    name,
    port,
    use_ssl,
    group_id,
    incoming,
    password,
    username,
    product_id,
    access_type,
    mail_server,
    mailbox_type,
    support_email,
    authentication,
    custom_mailbox,
    delete_from_server,
    default_reply_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_mailboxes_hashid
from {{ ref('email_mailbox_ab3') }}
-- email_mailboxes from {{ source('cta', '_airbyte_raw_email_mailboxes') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


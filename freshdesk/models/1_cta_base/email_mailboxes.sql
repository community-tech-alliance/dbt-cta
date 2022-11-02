{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_mailboxes_ab3') }}
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
from {{ ref('email_mailboxes_ab3') }}
-- email_mailboxes from {{ source('freshdesk_partner_a', '_airbyte_raw_email_mailboxes') }}
where 1 = 1


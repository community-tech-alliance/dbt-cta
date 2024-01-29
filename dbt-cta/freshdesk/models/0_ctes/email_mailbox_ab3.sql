{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_mailbox_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        'port',
        boolean_to_string('use_ssl'),
        'group_id',
        'incoming',
        'password',
        'username',
        'product_id',
        'access_type',
        'mail_server',
        'mailbox_type',
        'support_email',
        'authentication',
        'custom_mailbox',
        boolean_to_string('delete_from_server'),
        boolean_to_string('default_reply_email'),
    ]) }} as _airbyte_email_mailboxes_hashid,
    tmp.*
from {{ ref('email_mailbox_ab2') }} tmp
-- email_mailboxes
where 1 = 1


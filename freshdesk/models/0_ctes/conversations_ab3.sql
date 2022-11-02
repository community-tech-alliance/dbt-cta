{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('conversations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'body',
        'source',
        boolean_to_string('private'),
        'user_id',
        'category',
        boolean_to_string('incoming'),
        'body_text',
        array_to_string('cc_emails'),
        'ticket_id',
        array_to_string('to_emails'),
        array_to_string('bcc_emails'),
        'created_at',
        'from_email',
        'updated_at',
        array_to_string('attachments'),
        'support_email',
        object_to_string('source_additional_info'),
    ]) }} as _airbyte_conversations_hashid,
    tmp.*
from {{ ref('conversations_ab2') }} tmp
-- conversations
where 1 = 1


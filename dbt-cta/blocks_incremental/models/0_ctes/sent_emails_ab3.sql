{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sent_emails_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'recipients_count',
        'event_id',
        'list_id',
        'email_template_id',
        'subject',
        'created_at',
        adapter.quote('from'),
        'id',
        'team_id',
        'body',
        'sender_id',
    ]) }} as _airbyte_sent_emails_hashid,
    tmp.*
from {{ ref('sent_emails_ab2') }} tmp
-- sent_emails
where 1 = 1


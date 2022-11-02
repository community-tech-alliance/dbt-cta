{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tickets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        boolean_to_string('spam'),
        array_to_string('tags'),
        'type',
        object_to_string('stats'),
        'due_by',
        'source',
        'status',
        'subject',
        'group_id',
        'priority',
        array_to_string('cc_emails'),
        'fr_due_by',
        'nr_due_by',
        object_to_string('requester'),
        array_to_string('to_emails'),
        'company_id',
        'created_at',
        array_to_string('fwd_emails'),
        'product_id',
        'updated_at',
        'description',
        boolean_to_string('fr_escalated'),
        boolean_to_string('is_escalated'),
        boolean_to_string('nr_escalated'),
        'requester_id',
        'responder_id',
        object_to_string('custom_fields'),
        'email_config_id',
        array_to_string('reply_cc_emails'),
        'association_type',
        'description_text',
        array_to_string('ticket_cc_emails'),
        'associated_tickets_count',
    ]) }} as _airbyte_tickets_hashid,
    tmp.*
from {{ ref('tickets_ab2') }} tmp
-- tickets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


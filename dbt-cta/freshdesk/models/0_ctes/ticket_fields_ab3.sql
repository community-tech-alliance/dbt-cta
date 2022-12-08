{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ticket_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'type',
        'label',
        boolean_to_string('is_fsm'),
        array_to_string('choices'),
        boolean_to_string(adapter.quote('default')),
        'position',
        boolean_to_string('portal_cc'),
        'created_at',
        'updated_at',
        'description',
        'portal_cc_to',
        'dependent_fields',
        boolean_to_string('customers_can_edit'),
        'label_for_customers',
        boolean_to_string('required_for_agents'),
        boolean_to_string('required_for_closure'),
        boolean_to_string('displayed_to_customers'),
        boolean_to_string('required_for_customers'),
        boolean_to_string('field_update_in_progress'),
    ]) }} as _airbyte_ticket_fields_hashid,
    tmp.*
from {{ ref('ticket_fields_ab2') }} tmp
-- ticket_fields
where 1 = 1


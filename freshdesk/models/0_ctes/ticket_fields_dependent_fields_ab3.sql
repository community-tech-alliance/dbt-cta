{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ticket_fields_dependent_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ticket_fields_hashid',
        'id',
        'name',
        'label',
        'level',
        'created_at',
        'updated_at',
        'ticket_field_id',
        'label_for_customers',
    ]) }} as _airbyte_dependent_fields_hashid,
    tmp.*
from {{ ref('ticket_fields_dependent_fields_ab2') }} tmp
-- dependent_fields at ticket_fields/dependent_fields
where 1 = 1


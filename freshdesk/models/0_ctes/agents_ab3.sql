{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('agents_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        object_to_string('contact'),
        boolean_to_string('available'),
        'signature',
        'created_at',
        boolean_to_string('occasional'),
        'updated_at',
        'ticket_scope',
        'last_active_at',
        'available_since',
    ]) }} as _airbyte_agents_hashid,
    tmp.*
from {{ ref('agents_ab2') }} tmp
-- agents
where 1 = 1


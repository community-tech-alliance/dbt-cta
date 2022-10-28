{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('disputes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'amount',
        'charge',
        'object',
        'reason',
        'status',
        'created',
        'currency',
        object_to_string('evidence'),
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('evidence_details'),
        array_to_string('balance_transactions'),
        boolean_to_string('is_charge_refundable'),
    ]) }} as _airbyte_disputes_hashid,
    tmp.*
from {{ ref('disputes_ab2') }} tmp
-- disputes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


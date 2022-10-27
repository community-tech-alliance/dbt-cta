{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscriptions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('plan'),
        object_to_string('items'),
        'start',
        'object',
        'status',
        'billing',
        'created',
        'customer',
        object_to_string('discount'),
        'ended_at',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'quantity',
        'trial_end',
        'canceled_at',
        'tax_percent',
        'trial_start',
        'days_until_due',
        'current_period_end',
        'billing_cycle_anchor',
        boolean_to_string('cancel_at_period_end'),
        'current_period_start',
        'application_fee_percent',
    ]) }} as _airbyte_subscriptions_hashid,
    tmp.*
from {{ ref('subscriptions_ab2') }} tmp
-- subscriptions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


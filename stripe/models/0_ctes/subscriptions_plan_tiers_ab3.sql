{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscriptions_plan_tiers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_plan_hashid',
        'up_to',
        'flat_amount',
        'unit_amount',
    ]) }} as _airbyte_tiers_hashid,
    tmp.*
from {{ ref('subscriptions_plan_tiers_ab2') }} tmp
-- tiers at subscriptions/plan/tiers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


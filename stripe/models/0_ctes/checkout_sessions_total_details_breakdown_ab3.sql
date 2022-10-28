{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_total_details_hashid',
        array_to_string('taxes'),
        array_to_string('discounts'),
    ]) }} as _airbyte_breakdown_hashid,
    tmp.*
from {{ ref('checkout_sessions_total_details_breakdown_ab2') }} tmp
-- breakdown at checkout_sessions/total_details/breakdown
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


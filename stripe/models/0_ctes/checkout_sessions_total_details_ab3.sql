{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_total_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_hashid',
        object_to_string('breakdown'),
        'amount_tax',
        'amount_discount',
        'amount_shipping',
    ]) }} as _airbyte_total_details_hashid,
    tmp.*
from {{ ref('checkout_sessions_total_details_ab2') }} tmp
-- total_details at checkout_sessions_base/total_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


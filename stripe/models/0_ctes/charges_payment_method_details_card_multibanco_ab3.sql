{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_multibanco_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'entity',
        'reference',
    ]) }} as _airbyte_multibanco_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_multibanco_ab2') }} tmp
-- multibanco at charges/payment_method_details/card/multibanco
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


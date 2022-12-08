{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_checks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'cvc_check',
        'address_line1_check',
        'address_postal_code_check',
    ]) }} as _airbyte_checks_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_checks_ab2') }} tmp
-- checks at charges_base/payment_method_details/card/checks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


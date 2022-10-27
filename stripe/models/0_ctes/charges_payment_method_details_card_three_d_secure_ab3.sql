{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_three_d_secure_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'version',
        boolean_to_string('succeeded'),
        boolean_to_string('authenticated'),
    ]) }} as _airbyte_three_d_secure_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_three_d_secure_ab2') }} tmp
-- three_d_secure at charges/payment_method_details/card/three_d_secure
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


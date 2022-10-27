{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_installments_ab1') }}
select
    _airbyte_card_hashid,
    cast(plan as {{ type_json() }}) as plan,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_installments_ab1') }}
-- installments at charges/payment_method_details/card/installments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


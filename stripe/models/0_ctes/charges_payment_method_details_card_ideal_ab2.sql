{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_ideal_ab1') }}
select
    _airbyte_card_hashid,
    cast(bic as {{ dbt_utils.type_string() }}) as bic,
    cast(bank as {{ dbt_utils.type_string() }}) as bank,
    cast(iban_last4 as {{ dbt_utils.type_string() }}) as iban_last4,
    cast(verified_name as {{ dbt_utils.type_string() }}) as verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_ideal_ab1') }}
-- ideal at charges_base/payment_method_details/card/ideal
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


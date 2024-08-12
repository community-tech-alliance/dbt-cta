{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_sepa_debit_ab1') }}
select
    _airbyte_card_hashid,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(mandate as {{ dbt_utils.type_string() }}) as mandate,
    cast(bank_code as {{ dbt_utils.type_string() }}) as bank_code,
    cast(branch_code as {{ dbt_utils.type_string() }}) as branch_code,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_sepa_debit_ab1') }}
-- sepa_debit at charges_base/payment_method_details/card/sepa_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


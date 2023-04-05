{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_ab1') }}
select
    _airbyte_payment_method_options_hashid,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(mandate_options as {{ type_json() }}) as mandate_options,
    cast(verification_method as {{ dbt_utils.type_string() }}) as verification_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_acss_debit_ab1') }}
-- acss_debit at checkout_sessions_base/payment_method_options/acss_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


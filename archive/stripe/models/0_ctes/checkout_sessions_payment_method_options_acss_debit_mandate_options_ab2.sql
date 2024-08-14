{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab1') }}
select
    _airbyte_acss_debit_hashid,
    default_for,
    cast(payment_schedule as {{ dbt_utils.type_string() }}) as payment_schedule,
    cast(transaction_type as {{ dbt_utils.type_string() }}) as transaction_type,
    cast(custom_mandate_url as {{ dbt_utils.type_string() }}) as custom_mandate_url,
    cast(interval_description as {{ dbt_utils.type_string() }}) as interval_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab1') }}
-- mandate_options at checkout_sessions_base/payment_method_options/acss_debit/mandate_options
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


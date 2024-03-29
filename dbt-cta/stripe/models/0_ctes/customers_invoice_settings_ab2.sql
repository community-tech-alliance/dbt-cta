{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_invoice_settings_ab1') }}
select
    _airbyte_customers_hashid,
    cast(footer as {{ dbt_utils.type_string() }}) as footer,
    custom_fields,
    cast(default_payment_method as {{ dbt_utils.type_string() }}) as default_payment_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_invoice_settings_ab1') }}
-- invoice_settings at customers_base/invoice_settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_ach_credit_transfer_ab1') }}
select
    _airbyte_payment_method_details_hashid,
    cast(bank_name as {{ dbt_utils.type_string() }}) as bank_name,
    cast(swift_code as {{ dbt_utils.type_string() }}) as swift_code,
    cast(account_number as {{ dbt_utils.type_string() }}) as account_number,
    cast(routing_number as {{ dbt_utils.type_string() }}) as routing_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_ach_credit_transfer_ab1') }}
-- ach_credit_transfer at charges_base/payment_method_details/ach_credit_transfer
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


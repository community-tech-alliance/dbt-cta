{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_payment_options_ab1') }}
select
    _airbyte_page_hashid,
    cast(discover as {{ dbt_utils.type_bigint() }}) as discover,
    cast(amex as {{ dbt_utils.type_bigint() }}) as amex,
    cast(cash_only as {{ dbt_utils.type_bigint() }}) as cash_only,
    cast(visa as {{ dbt_utils.type_bigint() }}) as visa,
    cast(mastercard as {{ dbt_utils.type_bigint() }}) as mastercard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_payment_options_ab1') }}
-- payment_options at page/payment_options
where 1 = 1


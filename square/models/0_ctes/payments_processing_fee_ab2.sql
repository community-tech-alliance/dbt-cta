{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_processing_fee_ab1') }}
select
    _airbyte_payments_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(amount_money as {{ type_json() }}) as amount_money,
    cast(effective_at as {{ dbt_utils.type_string() }}) as effective_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_processing_fee_ab1') }}
-- processing_fee at payments/processing_fee
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


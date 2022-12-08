{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_tenders_ab1') }}
select
    _airbyte_orders_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(payment_id as {{ dbt_utils.type_string() }}) as payment_id,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    cast(amount_money as {{ type_json() }}) as amount_money,
    cast(card_details as {{ type_json() }}) as card_details,
    cast(cash_details as {{ type_json() }}) as cash_details,
    cast(transaction_id as {{ dbt_utils.type_string() }}) as transaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_ab1') }}
-- tenders at orders/tenders
where 1 = 1


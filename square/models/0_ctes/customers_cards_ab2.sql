{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_cards_ab1') }}
select
    _airbyte_customers_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(last_4 as {{ dbt_utils.type_string() }}) as last_4,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(card_brand as {{ dbt_utils.type_string() }}) as card_brand,
    cast(billing_address as {{ type_json() }}) as billing_address,
    cast(cardholder_name as {{ dbt_utils.type_string() }}) as cardholder_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_cards_ab1') }}
-- cards at customers/cards
where 1 = 1


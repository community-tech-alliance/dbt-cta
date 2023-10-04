{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_cards_billing_address_ab1') }}
select
    _airbyte_cards_hashid,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_cards_billing_address_ab1') }}
-- billing_address at customers/cards/billing_address
where 1 = 1

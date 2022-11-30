{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_tenders_card_details_ab1') }}
select
    _airbyte_tenders_hashid,
    cast(card as {{ type_json() }}) as card,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(entry_method as {{ dbt_utils.type_string() }}) as entry_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_card_details_ab1') }}
-- card_details at orders/tenders/card_details
where 1 = 1


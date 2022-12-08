{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_tenders_card_details_card_ab1') }}
select
    _airbyte_card_details_hashid,
    cast(last_4 as {{ dbt_utils.type_string() }}) as last_4,
    cast(card_brand as {{ dbt_utils.type_string() }}) as card_brand,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_card_details_card_ab1') }}
-- card at orders/tenders/card_details/card
where 1 = 1


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchases_PurchaseEx_ab1') }}
select
    _airbyte_purchases_hashid,
    {{ adapter.quote('any') }},
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_PurchaseEx_ab1') }}
-- PurchaseEx at purchases/PurchaseEx
where 1 = 1

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders_base') }}
{{ unnest_cte(ref('purchase_orders_base'), 'purchase_orders', 'CustomField') }}
select
    _airbyte_purchase_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Type'], ['Type']) }} as Type,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['DefinitionId'], ['DefinitionId']) }} as DefinitionId,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Name'], ['Name']) }} as Name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_base') }}
-- CustomField at purchase_orders/CustomField
{{ cross_join_unnest('purchase_orders', 'CustomField') }}
where
    1 = 1
    and CustomField is not null

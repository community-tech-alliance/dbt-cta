{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sales_receipts_Line_DiscountLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    {{ cast_to_boolean('PercentBased') }} as PercentBased,
    cast(DiscountAccountRef as {{ type_json() }}) as DiscountAccountRef,
    cast(DiscountPercent as {{ dbt_utils.type_bigint() }}) as DiscountPercent,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_Line_DiscountLineDetail_ab1') }}
-- DiscountLineDetail at sales_receipts/Line/DiscountLineDetail
where 1 = 1

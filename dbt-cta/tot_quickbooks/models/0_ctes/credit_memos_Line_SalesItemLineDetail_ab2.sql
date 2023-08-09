{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('credit_memos_Line_SalesItemLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(UnitPrice as {{ dbt_utils.type_bigint() }}) as UnitPrice,
    cast(TaxCodeRef as {{ type_json() }}) as TaxCodeRef,
    cast(Qty as {{ dbt_utils.type_bigint() }}) as Qty,
    cast(ItemRef as {{ type_json() }}) as ItemRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('credit_memos_Line_SalesItemLineDetail_ab1') }}
-- SalesItemLineDetail at credit_memos/Line/SalesItemLineDetail
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('credit_memos_TxnTaxDetail_ab1') }}
select
    _airbyte_credit_memos_hashid,
    cast(TotalTax as {{ dbt_utils.type_bigint() }}) as TotalTax,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('credit_memos_TxnTaxDetail_ab1') }}
-- TxnTaxDetail at credit_memos/TxnTaxDetail
where 1 = 1


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('estimates_TxnTaxDetail_ab1') }}
select
    _airbyte_estimates_hashid,
    cast(TotalTax as {{ dbt_utils.type_float() }}) as TotalTax,
    cast(TxnTaxCodeRef as {{ type_json() }}) as TxnTaxCodeRef,
    TaxLine,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_TxnTaxDetail_ab1') }}
-- TxnTaxDetail at estimates/TxnTaxDetail
where 1 = 1

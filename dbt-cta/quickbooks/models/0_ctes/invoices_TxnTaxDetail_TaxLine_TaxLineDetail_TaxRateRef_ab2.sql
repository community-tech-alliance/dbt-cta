{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab1') }}
select
    _airbyte_TaxLineDetail_hashid,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab1') }}
-- TaxRateRef at invoices/TxnTaxDetail/TaxLine/TaxLineDetail/TaxRateRef
where 1 = 1


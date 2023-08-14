{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_ab1') }}
select
    _airbyte_SalesTaxRateList_hashid,
    cast(TaxOrder as {{ dbt_utils.type_bigint() }}) as TaxOrder,
    cast(TaxRateRef as {{ type_json() }}) as TaxRateRef,
    cast(TaxTypeApplicable as {{ dbt_utils.type_string() }}) as TaxTypeApplicable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_ab1') }}
-- TaxRateDetail at tax_codes/SalesTaxRateList/TaxRateDetail
where 1 = 1


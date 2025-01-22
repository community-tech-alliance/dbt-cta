{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_TaxRateRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_TaxRateDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_TaxRateRef_hashid,
    tmp.*
from {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_TaxRateRef_ab2') }} as tmp
-- TaxRateRef at tax_codes/SalesTaxRateList/TaxRateDetail/TaxRateRef
where 1 = 1

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_SalesTaxRateList_hashid',
        'TaxOrder',
        object_to_string('TaxRateRef'),
        'TaxTypeApplicable',
    ]) }} as _airbyte_TaxRateDetail_hashid,
    tmp.*
from {{ ref('tax_codes_SalesTaxRateList_TaxRateDetail_ab2') }} tmp
-- TaxRateDetail at tax_codes/SalesTaxRateList/TaxRateDetail
where 1 = 1


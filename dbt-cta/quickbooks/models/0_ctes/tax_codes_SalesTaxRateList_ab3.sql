{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_codes_SalesTaxRateList_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_tax_codes_hashid',
        array_to_string('TaxRateDetail'),
    ]) }} as _airbyte_SalesTaxRateList_hashid,
    tmp.*
from {{ ref('tax_codes_SalesTaxRateList_ab2') }} tmp
-- SalesTaxRateList at tax_codes/SalesTaxRateList
where 1 = 1


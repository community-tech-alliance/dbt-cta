{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('estimates_TxnTaxDetail_TaxLine_TaxLineDetail_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_TaxLine_hashid',
        boolean_to_string('PercentBased'),
        object_to_string('TaxRateRef'),
        'NetAmountTaxable',
        'TaxPercent',
    ]) }} as _airbyte_TaxLineDetail_hashid,
    tmp.*
from {{ ref('estimates_TxnTaxDetail_TaxLine_TaxLineDetail_ab2') }} tmp
-- TaxLineDetail at estimates/TxnTaxDetail/TaxLine/TaxLineDetail
where 1 = 1


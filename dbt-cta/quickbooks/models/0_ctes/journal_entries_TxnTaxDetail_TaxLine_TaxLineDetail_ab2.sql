{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_ab1') }}
select
    _airbyte_TaxLine_hashid,
    {{ cast_to_boolean('PercentBased') }} as PercentBased,
    cast(TaxRateRef as {{ type_json() }}) as TaxRateRef,
    cast(TaxInclusiveAmount as {{ dbt_utils.type_float() }}) as TaxInclusiveAmount,
    cast(OverrideDeltaAmount as {{ dbt_utils.type_float() }}) as OverrideDeltaAmount,
    cast(NetAmountTaxable as {{ dbt_utils.type_float() }}) as NetAmountTaxable,
    cast(TaxPercent as {{ dbt_utils.type_float() }}) as TaxPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_ab1') }}
-- TaxLineDetail at journal_entries/TxnTaxDetail/TaxLine/TaxLineDetail
where 1 = 1

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('journal_entries_TxnTaxDetail_TaxLine_base') }}
select
    _airbyte_TaxLine_hashid,
    {{ json_extract_scalar('TaxLineDetail', ['PercentBased'], ['PercentBased']) }} as PercentBased,
    {{ json_extract('table_alias', 'TaxLineDetail', ['TaxRateRef'], ['TaxRateRef']) }} as TaxRateRef,
    {{ json_extract_scalar('TaxLineDetail', ['TaxInclusiveAmount'], ['TaxInclusiveAmount']) }} as TaxInclusiveAmount,
    {{ json_extract_scalar('TaxLineDetail', ['OverrideDeltaAmount'], ['OverrideDeltaAmount']) }} as OverrideDeltaAmount,
    {{ json_extract_scalar('TaxLineDetail', ['NetAmountTaxable'], ['NetAmountTaxable']) }} as NetAmountTaxable,
    {{ json_extract_scalar('TaxLineDetail', ['TaxPercent'], ['TaxPercent']) }} as TaxPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_TxnTaxDetail_TaxLine_base') }} as table_alias
-- TaxLineDetail at journal_entries/TxnTaxDetail/TaxLine/TaxLineDetail
where
    1 = 1
    and TaxLineDetail is not null

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoices_TxnTaxDetail') }}
{{ unnest_cte(ref('invoices_TxnTaxDetail'), 'TxnTaxDetail', 'TaxLine') }}
select
    _airbyte_TxnTaxDetail_hashid,
    {{ json_extract_scalar(unnested_column_value('TaxLine'), ['DetailType'], ['DetailType']) }} as DetailType,
    {{ json_extract('', unnested_column_value('TaxLine'), ['TaxLineDetail'], ['TaxLineDetail']) }} as TaxLineDetail,
    {{ json_extract_scalar(unnested_column_value('TaxLine'), ['Amount'], ['Amount']) }} as Amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_TxnTaxDetail') }} as table_alias
-- TaxLine at invoices/TxnTaxDetail/TaxLine
{{ cross_join_unnest('TxnTaxDetail', 'TaxLine') }}
where 1 = 1
and TaxLine is not null


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('estimates_TxnTaxDetail_base') }}
{{ unnest_cte(ref('estimates_TxnTaxDetail_base'), 'TxnTaxDetail', 'TaxLine') }}
select
    _airbyte_TxnTaxDetail_hashid,
    {{ json_extract_scalar(unnested_column_value('TaxLine'), ['DetailType'], ['DetailType']) }} as DetailType,
    {{ json_extract('', unnested_column_value('TaxLine'), ['TaxLineDetail'], ['TaxLineDetail']) }} as TaxLineDetail,
    {{ json_extract_scalar(unnested_column_value('TaxLine'), ['Amount'], ['Amount']) }} as Amount,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_TxnTaxDetail_base') }}
-- TaxLine at estimates/TxnTaxDetail/TaxLine
{{ cross_join_unnest('TxnTaxDetail', 'TaxLine') }}
where
    1 = 1
    and TaxLine is not null

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('tax_codes_SalesTaxRateList_base') }}
{{ unnest_cte(ref('tax_codes_SalesTaxRateList'), 'SalesTaxRateList', 'TaxRateDetail') }}
select
    _airbyte_SalesTaxRateList_hashid,
    {{ json_extract_scalar(unnested_column_value('TaxRateDetail'), ['TaxOrder'], ['TaxOrder']) }} as TaxOrder,
    {{ json_extract('', unnested_column_value('TaxRateDetail'), ['TaxRateRef'], ['TaxRateRef']) }} as TaxRateRef,
    {{ json_extract_scalar(unnested_column_value('TaxRateDetail'), ['TaxTypeApplicable'], ['TaxTypeApplicable']) }} as TaxTypeApplicable,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_codes_SalesTaxRateList_base') }}
-- TaxRateDetail at tax_codes/SalesTaxRateList/TaxRateDetail
{{ cross_join_unnest('SalesTaxRateList', 'TaxRateDetail') }}
where
    1 = 1
    and TaxRateDetail is not null

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('tax_codes') }}
select
    _airbyte_tax_codes_hashid,
    {{ json_extract_array('SalesTaxRateList', ['TaxRateDetail'], ['TaxRateDetail']) }} as TaxRateDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_codes') }} as table_alias
-- SalesTaxRateList at tax_codes/SalesTaxRateList
where 1 = 1
and SalesTaxRateList is not null


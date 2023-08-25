{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('discounts') }}
select
    _airbyte_discounts_hashid,
    {{ json_extract_scalar('discount_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('discount_data', ['percentage'], ['percentage']) }} as percentage,
    {{ json_extract('table_alias', 'discount_data', ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract_scalar('discount_data', ['pin_required'], ['pin_required']) }} as pin_required,
    {{ json_extract_scalar('discount_data', ['discount_type'], ['discount_type']) }} as discount_type,
    {{ json_extract_scalar('discount_data', ['modify_tax_basis'], ['modify_tax_basis']) }} as modify_tax_basis,
    {{ json_extract_scalar('discount_data', ['application_method'], ['application_method']) }} as application_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('discounts_base') }} as table_alias
-- discount_data at discounts/discount_data
where
    1 = 1
    and discount_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}


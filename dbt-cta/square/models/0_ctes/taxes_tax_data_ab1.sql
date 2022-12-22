{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('taxes') }}
select
    _airbyte_taxes_hashid,
    {{ json_extract_scalar('tax_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('tax_data', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('tax_data', ['percentage'], ['percentage']) }} as percentage,
    {{ json_extract_scalar('tax_data', ['tax_type_id'], ['tax_type_id']) }} as tax_type_id,
    {{ json_extract_scalar('tax_data', ['tax_type_name'], ['tax_type_name']) }} as tax_type_name,
    {{ json_extract_scalar('tax_data', ['inclusion_type'], ['inclusion_type']) }} as inclusion_type,
    {{ json_extract_scalar('tax_data', ['calculation_phase'], ['calculation_phase']) }} as calculation_phase,
    {{ json_extract_scalar('tax_data', ['applies_to_custom_amounts'], ['applies_to_custom_amounts']) }} as applies_to_custom_amounts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('taxes_base') }} as table_alias
-- tax_data at taxes/tax_data
where 1 = 1
and tax_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}


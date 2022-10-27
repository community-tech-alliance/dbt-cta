{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_products') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_string_array('_airbyte_data', ['images'], ['images']) }} as images,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['caption'], ['caption']) }} as caption,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['updated'], ['updated']) }} as updated,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['shippable'], ['shippable']) }} as shippable,
    {{ json_extract_string_array('_airbyte_data', ['attributes'], ['attributes']) }} as attributes,
    {{ json_extract_scalar('_airbyte_data', ['unit_label'], ['unit_label']) }} as unit_label,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_string_array('_airbyte_data', ['deactivate_on'], ['deactivate_on']) }} as deactivate_on,
    {{ json_extract('table_alias', '_airbyte_data', ['package_dimensions'], ['package_dimensions']) }} as package_dimensions,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_products') }} as table_alias
-- products
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


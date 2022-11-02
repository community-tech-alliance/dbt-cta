{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products_base') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar('package_dimensions', ['width'], ['width']) }} as width,
    {{ json_extract_scalar('package_dimensions', ['height'], ['height']) }} as height,
    {{ json_extract_scalar('package_dimensions', ['length'], ['length']) }} as length,
    {{ json_extract_scalar('package_dimensions', ['weight'], ['weight']) }} as weight,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_base') }} as table_alias
-- package_dimensions at products_base/package_dimensions
where 1 = 1
and package_dimensions is not null
{{ incremental_clause('_airbyte_emitted_at') }}


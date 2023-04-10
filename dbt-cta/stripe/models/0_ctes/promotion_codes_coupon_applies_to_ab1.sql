{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotion_codes_coupon_base') }}
select
    _airbyte_coupon_hashid,
    {{ json_extract_string_array('applies_to', ['products'], ['products']) }} as products,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_codes_coupon_base') }} as table_alias
-- applies_to at promotion_codes_base/coupon/applies_to
where 1 = 1
and applies_to is not null
{{ incremental_clause('_airbyte_emitted_at') }}


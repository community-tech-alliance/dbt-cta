{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotion_codes_coupon_applies_to_ab1') }}
select
    _airbyte_coupon_hashid,
    products,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_codes_coupon_applies_to_ab1') }}
-- applies_to at promotion_codes_base/coupon/applies_to
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


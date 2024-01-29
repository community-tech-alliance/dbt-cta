{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotion_codes_coupon_applies_to_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_coupon_hashid',
        array_to_string('products'),
    ]) }} as _airbyte_applies_to_hashid,
    tmp.*
from {{ ref('promotion_codes_coupon_applies_to_ab2') }} as tmp
-- applies_to at promotion_codes_base/coupon/applies_to
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('discounts_discount_data_ab3') }}
select
    _airbyte_discounts_hashid,
    name,
    percentage,
    amount_money,
    pin_required,
    discount_type,
    modify_tax_basis,
    application_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_discount_data_hashid
from {{ ref('discounts_discount_data_ab3') }}
-- discount_data at discounts/discount_data from {{ ref('discounts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


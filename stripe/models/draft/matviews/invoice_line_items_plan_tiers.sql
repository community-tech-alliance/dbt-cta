{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_line_items_plan_tiers_ab3') }}
select
    _airbyte_plan_hashid,
    up_to,
    flat_amount,
    unit_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tiers_hashid
from {{ ref('invoice_line_items_plan_tiers_ab3') }}
-- tiers at invoice_line_items/plan/tiers from {{ ref('invoice_line_items_plan') }}
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_line_items_period_ab3') }}
select
    _airbyte_invoice_line_items_hashid,
    {{ adapter.quote('end') }},
    start,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_period_hashid
from {{ ref('invoice_line_items_period_ab3') }}
-- period at invoice_line_items/period from {{ ref('invoice_line_items') }}
where 1 = 1


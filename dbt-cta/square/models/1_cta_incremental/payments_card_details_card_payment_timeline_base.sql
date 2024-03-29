{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payments_card_details_card_payment_timeline_ab3') }}
select
    _airbyte_card_details_hashid,
    voided_at,
    captured_at,
    authorized_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_payment_timeline_hashid
from {{ ref('payments_card_details_card_payment_timeline_ab3') }}
-- card_payment_timeline at payments/card_details/card_payment_timeline from {{ ref('payments_card_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payments_card_details_ab3') }}
select
    _airbyte_payments_hashid,
    card,
    status,
    avs_status,
    cvv_status,
    entry_method,
    card_payment_timeline,
    statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_details_hashid
from {{ ref('payments_card_details_ab3') }}
-- card_details at payments/card_details from {{ ref('payments') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


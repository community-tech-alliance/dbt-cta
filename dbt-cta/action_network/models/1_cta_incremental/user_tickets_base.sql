{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_tickets_ab4') }}
select
    id,
    amount,
    quantity,
    ticket_id,
    created_at,
    updated_at,
    ticket_price,
    ticket_receipt_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_tickets_hashid
from {{ ref('user_tickets_ab4') }}
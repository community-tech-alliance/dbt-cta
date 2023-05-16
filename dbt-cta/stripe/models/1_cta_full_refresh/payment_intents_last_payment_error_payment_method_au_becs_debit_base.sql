{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_au_becs_debit_ab3') }}
select
    _airbyte_payment_method_hashid,
    last4,
    bsb_number,
    fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_au_becs_debit_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_au_becs_debit_ab3') }}
-- au_becs_debit at payment_intents_base/last_payment_error/payment_method/au_becs_debit from {{ ref('payment_intents_last_payment_error_payment_method_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


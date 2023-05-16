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
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab3') }}
select
    _airbyte_acss_debit_hashid,
    default_for,
    payment_schedule,
    transaction_type,
    custom_mandate_url,
    interval_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mandate_options_hashid
from {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab3') }}
-- mandate_options at checkout_sessions_base/payment_method_options/acss_debit/mandate_options from {{ ref('checkout_sessions_payment_method_options_acss_debit_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


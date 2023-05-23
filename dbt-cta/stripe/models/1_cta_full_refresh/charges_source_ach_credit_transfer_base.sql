{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_ach_credit_transfer_ab3') }}
select
    _airbyte_source_hashid,
    bank_name,
    swift_code,
    fingerprint,
    account_number,
    routing_number,
    refund_account_number,
    refund_routing_number,
    refund_account_holder_name,
    refund_account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ach_credit_transfer_hashid
from {{ ref('charges_source_ach_credit_transfer_ab3') }}
-- ach_credit_transfer at charges_base/source/ach_credit_transfer from {{ ref('charges_source_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


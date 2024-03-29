{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('disputes_evidence_ab3') }}
select
    _airbyte_disputes_hashid,
    receipt,
    service_date,
    customer_name,
    refund_policy,
    shipping_date,
    billing_address,
    shipping_address,
    shipping_carrier,
    customer_signature,
    uncategorized_file,
    uncategorized_text,
    access_activity_log,
    cancellation_policy,
    duplicate_charge_id,
    product_description,
    customer_purchase_ip,
    cancellation_rebuttal,
    service_documentation,
    customer_communication,
    customer_email_address,
    shipping_documentation,
    refund_policy_disclosure,
    shipping_tracking_number,
    refund_refusal_explanation,
    duplicate_charge_explanation,
    cancellation_policy_disclosure,
    duplicate_charge_documentation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_evidence_hashid
from {{ ref('disputes_evidence_ab3') }}
-- evidence at disputes_base/evidence from {{ ref('disputes_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


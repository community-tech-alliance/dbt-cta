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
-- depends_on: {{ ref('charges_payment_method_details_card_ab3') }}
select
    _airbyte_payment_method_details_hashid,
    id,
    eps,
    p24,
    name,
    type,
    brand,
    ideal,
    last4,
    checks,
    klarna,
    object,
    sofort,
    wallet,
    wechat,
    country,
    funding,
    giropay,
    network,
    customer,
    exp_year,
    metadata,
    cvc_check,
    exp_month,
    multibanco,
    sepa_debit,
    address_zip,
    fingerprint,
    address_city,
    card_present,
    installments,
    address_line1,
    address_line2,
    address_state,
    dynamic_last4,
    stripe_account,
    three_d_secure,
    address_country,
    address_zip_check,
    address_line1_check,
    tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_hashid
from {{ ref('charges_payment_method_details_card_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


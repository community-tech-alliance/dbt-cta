{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('external_account_cards_ab3') }}
select
    id,
    name,
    brand,
    last4,
    object,
    account,
    country,
    funding,
    exp_year,
    metadata,
    cvc_check,
    exp_month,
    redaction,
    address_zip,
    fingerprint,
    address_city,
    address_line1,
    address_line2,
    address_state,
    dynamic_last4,
    address_country,
    address_zip_check,
    address_line1_check,
    tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_external_account_cards_hashid
from {{ ref('external_account_cards_ab3') }}
-- external_account_cards from {{ source('cta', '_airbyte_raw_external_account_cards') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


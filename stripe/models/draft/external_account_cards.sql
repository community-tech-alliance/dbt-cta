{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
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
-- external_account_cards from {{ source('stripe_partner_a', '_airbyte_raw_external_account_cards') }}
where 1 = 1


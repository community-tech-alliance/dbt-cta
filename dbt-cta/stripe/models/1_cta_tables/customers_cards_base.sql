{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_cards_ab3') }}
select
    _airbyte_customers_hashid,
    id,
    name,
    type,
    brand,
    last4,
    object,
    country,
    funding,
    customer,
    exp_year,
    metadata,
    cvc_check,
    exp_month,
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
    _airbyte_cards_hashid
from {{ ref('customers_cards_ab3') }}
-- cards at customers_base/cards from {{ ref('customers_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


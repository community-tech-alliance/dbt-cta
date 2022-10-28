{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_ab3') }}
select
    id,
    name,
    cards,
    email,
    phone,
    object,
    address,
    balance,
    created,
    sources,
    currency,
    discount,
    livemode,
    metadata,
    shipping,
    tax_info,
    delinquent,
    tax_exempt,
    description,
    default_card,
    subscriptions,
    default_source,
    invoice_prefix,
    account_balance,
    invoice_settings,
    preferred_locales,
    next_invoice_sequence,
    tax_info_verification,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customers_hashid
from {{ ref('customers_ab3') }}
-- customers from {{ source('cta', '_airbyte_raw_customers') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


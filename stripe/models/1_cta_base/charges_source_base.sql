{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_ab3') }}
select
    _airbyte_charges_hashid,
    id,
    eps,
    card,
    flow,
    name,
    type,
    brand,
    ideal,
    last4,
    owner,
    usage,
    alipay,
    amount,
    object,
    status,
    country,
    created,
    funding,
    currency,
    customer,
    exp_year,
    livemode,
    metadata,
    receiver,
    redirect,
    cvc_check,
    exp_month,
    bancontact,
    multibanco,
    address_zip,
    fingerprint,
    address_city,
    address_line1,
    address_line2,
    address_state,
    client_secret,
    dynamic_last4,
    address_country,
    address_zip_check,
    ach_credit_transfer,
    address_line1_check,
    tokenization_method,
    statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_source_hashid
from {{ ref('charges_source_ab3') }}
-- source at charges/source from {{ ref('charges') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


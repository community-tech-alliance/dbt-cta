{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_card_ab3') }}
select
    _airbyte_source_hashid,
    name,
    type,
    brand,
    last4,
    country,
    funding,
    exp_year,
    cvc_check,
    exp_month,
    fingerprint,
    dynamic_last4,
    three_d_secure,
    address_zip_check,
    address_line1_check,
    tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_hashid
from {{ ref('charges_source_card_ab3') }}
-- card at charges_base/source/card from {{ ref('charges_source') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_card_ab3') }}
select
    _airbyte_charges_hashid,
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
    _airbyte_card_hashid
from {{ ref('charges_card_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


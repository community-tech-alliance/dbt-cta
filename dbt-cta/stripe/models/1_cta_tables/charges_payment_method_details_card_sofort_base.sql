{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_sofort_ab3') }}
select
    _airbyte_card_hashid,
    bic,
    country,
    bank_code,
    bank_name,
    iban_last4,
    verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sofort_hashid
from {{ ref('charges_payment_method_details_card_sofort_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


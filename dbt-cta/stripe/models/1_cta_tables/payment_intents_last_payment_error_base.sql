{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_ab3') }}
select
    _airbyte_payment_intents_hashid,
    code,
    type,
    param,
    charge,
    doc_url,
    message,
    decline_code,
    payment_method,
    payment_method_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_last_payment_error_hashid
from {{ ref('payment_intents_last_payment_error_ab3') }}
-- last_payment_error at payment_intents_base/last_payment_error from {{ ref('payment_intents_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_fraud_details_ab3') }}
select
    _airbyte_charges_hashid,
    stripe_report,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_fraud_details_hashid
from {{ ref('charges_fraud_details_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


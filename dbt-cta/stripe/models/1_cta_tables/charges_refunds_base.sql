{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_refunds_ab3') }}
select
    _airbyte_charges_hashid,
    url,
    data,
    object,
    has_more,
    total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_refunds_hashid
from {{ ref('charges_refunds_ab3') }}
-- refunds at charges_base/refunds from {{ ref('charges_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ source('cta','adaccounts_base') }}, {{ ref('adaccounts_regulations_ab3') }}
select
    _airbyte_adaccounts_hashid,
    restricted_delivery_signals,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_regulations_hashid
from {{ ref('adaccounts_regulations_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


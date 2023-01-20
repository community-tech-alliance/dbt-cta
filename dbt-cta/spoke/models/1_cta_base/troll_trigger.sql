{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('troll_trigger_ab3') }}
select
    mode,
    token,
    organization_id,
    compiled_tsquery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_troll_trigger_hashid
from {{ ref('troll_trigger_ab3') }}
-- troll_trigger from {{ source('public', '_airbyte_raw_troll_trigger') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- depends_on: {{ ref('adsquads_targeting_geos_ab3') }}
select
    _airbyte_targeting_hashid,
    country_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_geos_hashid
from {{ ref('adsquads_targeting_geos_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


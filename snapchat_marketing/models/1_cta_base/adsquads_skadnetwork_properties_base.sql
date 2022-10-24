{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}

-- depends_on: {{ ref('adsquads_skadnetwork_properties_ab3') }}
select
    _airbyte_adsquads_hashid,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_skadnetwork_properties_hashid
from {{ ref('adsquads_skadnetwork_properties_ab3') }}
-- skadnetwork_properties at adsquads_base/skadnetwork_properties from {{ ref('adsquads_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


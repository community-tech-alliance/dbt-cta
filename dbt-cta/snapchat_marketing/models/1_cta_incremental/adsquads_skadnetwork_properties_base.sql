{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_squad_id'
) }}

-- depends_on: {{ ref('adsquads_skadnetwork_properties_ab2') }}
select
    ad_squad_id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_skadnetwork_properties_ab2') }}
-- skadnetwork_properties at adsquads_base/skadnetwork_properties from {{ ref('adsquads_base') }}

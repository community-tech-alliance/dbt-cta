{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_squad_id'
) }}

-- depends_on: {{ ref('adsquads_skadnetwork_properties_ab2') }}
select
    ad_squad_id,
    status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_skadnetwork_properties_ab2') }}
-- skadnetwork_properties at adsquads_base/skadnetwork_properties from {{ ref('adsquads_base') }}

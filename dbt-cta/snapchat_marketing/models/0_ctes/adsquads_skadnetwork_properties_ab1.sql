{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adsquads_base') }}
select
    id as ad_squad_id,
    {{ json_extract_scalar('skadnetwork_properties', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_base') }}
-- skadnetwork_properties at adsquads_base/skadnetwork_properties
where
    1 = 1
    and skadnetwork_properties is not null

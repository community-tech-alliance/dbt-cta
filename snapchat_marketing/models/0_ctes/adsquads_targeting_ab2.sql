{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adsquads_targeting_ab1') }}
select
    _airbyte_adsquads_hashid,
    geos,
    demographics,
    {{ cast_to_boolean('regulated_content') }} as regulated_content,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_targeting_ab1') }}
-- targeting at adsquads/targeting
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


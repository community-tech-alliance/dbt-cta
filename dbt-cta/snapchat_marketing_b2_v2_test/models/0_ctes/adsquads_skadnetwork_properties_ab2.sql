{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adsquads_skadnetwork_properties_ab1') }}
select
    ad_squad_id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_skadnetwork_properties_ab1') }}
-- skadnetwork_properties at adsquads/skadnetwork_properties
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}


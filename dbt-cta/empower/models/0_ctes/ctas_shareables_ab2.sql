{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctas_shareables_ab1') }}
select
    _airbyte_ctas_hashid,
    cast(displayLabel as {{ dbt_utils.type_string() }}) as displayLabel,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_shareables_ab1') }}
-- shareables at ctas/shareables
where 1 = 1


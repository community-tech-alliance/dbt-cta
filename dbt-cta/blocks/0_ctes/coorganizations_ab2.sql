{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('coorganizations_ab1') }}
select
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('coorganizations_ab1') }}
-- coorganizations
where 1 = 1


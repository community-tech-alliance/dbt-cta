{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activism_options_configs_ab1') }}
select
    skills,
    campaigns,
    languages,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activism_options_configs_ab1') }}
-- activism_options_configs
where 1 = 1


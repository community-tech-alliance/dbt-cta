{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_phone_verification_scripts_ab1') }}
select
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(structure as {{ dbt_utils.type_string() }}) as structure,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_phone_verification_scripts_ab1') }}
-- quality_control_phone_verification_scripts
where 1 = 1


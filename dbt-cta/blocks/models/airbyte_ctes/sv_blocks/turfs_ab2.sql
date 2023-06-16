{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('turfs_ab1') }}
select
    cast(van_api_config as {{ dbt_utils.type_string() }}) as van_api_config,
    cast(turf_level_id as {{ dbt_utils.type_bigint() }}) as turf_level_id,
    cast(qc_turnaround_days as {{ dbt_utils.type_bigint() }}) as qc_turnaround_days,
    cast(default_phone_verification_script_id as {{ dbt_utils.type_bigint() }}) as default_phone_verification_script_id,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(petition_requirements as {{ dbt_utils.type_string() }}) as petition_requirements,
    cast(min_phone_verification_rounds as {{ dbt_utils.type_bigint() }}) as min_phone_verification_rounds,
    {{ cast_to_boolean('archived') }} as archived,
    {{ cast_to_boolean('voter_registration_enabled') }} as voter_registration_enabled,
    cast(depth as {{ dbt_utils.type_bigint() }}) as depth,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast(qc_config as {{ dbt_utils.type_string() }}) as qc_config,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(voter_registration_config as {{ dbt_utils.type_string() }}) as voter_registration_config,
    cast(phone_verification_language as {{ dbt_utils.type_string() }}) as phone_verification_language,
    cast(min_phone_verification_percent as {{ dbt_utils.type_bigint() }}) as min_phone_verification_percent,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(lft as {{ dbt_utils.type_bigint() }}) as lft,
    cast(rgt as {{ dbt_utils.type_bigint() }}) as rgt,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('turfs_ab1') }}
-- turfs
where 1 = 1


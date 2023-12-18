{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_flags_voter_registration_scans_ab1') }}
select
    cast(voter_registration_scan_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_id,
    cast(quality_control_flag_id as {{ dbt_utils.type_bigint() }}) as quality_control_flag_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_flags_voter_registration_scans_ab1') }}
-- quality_control_flags_voter_registration_scans
where 1 = 1


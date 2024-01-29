{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_flags_voter_registration_scans_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'voter_registration_scan_id',
        'quality_control_flag_id',
    ]) }} as _airbyte_quality_control_flags_voter_registration_scans_hashid,
    tmp.*
from {{ ref('quality_control_flags_voter_registration_scans_ab2') }} tmp
-- quality_control_flags_voter_registration_scans
where 1 = 1


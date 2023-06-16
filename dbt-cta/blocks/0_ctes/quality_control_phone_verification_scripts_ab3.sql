{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_phone_verification_scripts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'turf_id',
        'language',
        'id',
        'structure',
    ]) }} as _airbyte_quality_control_phone_verification_scripts_hashid,
    tmp.*
from {{ ref('quality_control_phone_verification_scripts_ab2') }} tmp
-- quality_control_phone_verification_scripts
where 1 = 1


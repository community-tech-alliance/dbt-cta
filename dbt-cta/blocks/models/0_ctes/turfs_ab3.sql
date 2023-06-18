{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('turfs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'van_api_config',
        'turf_level_id',
        'qc_turnaround_days',
        'default_phone_verification_script_id',
        'extras',
        'created_at',
        'petition_requirements',
        'min_phone_verification_rounds',
        boolean_to_string('archived'),
        boolean_to_string('voter_registration_enabled'),
        'depth',
        'updated_at',
        'parent_id',
        'qc_config',
        'name',
        'voter_registration_config',
        'phone_verification_language',
        'min_phone_verification_percent',
        'id',
        'lft',
        'rgt',
        'slug',
    ]) }} as _airbyte_turfs_hashid,
    tmp.*
from {{ ref('turfs_ab2') }} tmp
-- turfs
where 1 = 1


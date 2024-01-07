{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'turfs') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    van_api_config,
    turf_level_id,
    qc_turnaround_days,
    default_phone_verification_script_id,
    extras,
    created_at,
    petition_requirements,
    min_phone_verification_rounds,
    archived,
    voter_registration_enabled,
    depth,
    updated_at,
    parent_id,
    qc_config,
    name,
    options,
    reporting_config,
    voter_registration_config,
    phone_verification_language,
    min_phone_verification_percent,
    id,
    lft,
    rgt,
   {{ dbt_utils.surrogate_key([
     'van_api_config',
    'turf_level_id',
    'qc_turnaround_days',
    'default_phone_verification_script_id',
    'extras',
    'petition_requirements',
    'min_phone_verification_rounds',
    'archived',
    'voter_registration_enabled',
    'depth',
    'parent_id',
    'qc_config',
    'name',
    'options',
    'reporting_config',
    'voter_registration_config',
    'phone_verification_language',
    'min_phone_verification_percent',
    'id',
    'lft',
    'rgt'
    ]) }} as _airbyte_turfs_hashid
from {{ source('cta', 'turfs') }}

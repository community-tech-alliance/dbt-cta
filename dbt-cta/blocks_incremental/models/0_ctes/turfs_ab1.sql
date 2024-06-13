
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
   id,
   lft,
   rgt,
   name,
   depth,
   extras,
   options,
   archived,
   parent_id,
   qc_config,
   created_at,
   updated_at,
   turf_level_id,
   van_api_config,
   reporting_config,
   qc_turnaround_days,
   petition_requirements,
   voter_registration_config,
   voter_registration_enabled,
   phone_verification_language,
   min_phone_verification_rounds,
   min_phone_verification_percent,
   default_phone_verification_script_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'lft',
    'rgt',
    'name',
    'depth',
    'extras',
    'options',
    'archived',
    'parent_id',
    'qc_config',
    'turf_level_id',
    'van_api_config',
    'reporting_config',
    'qc_turnaround_days',
    'petition_requirements',
    'voter_registration_config',
    'voter_registration_enabled',
    'phone_verification_language',
    'min_phone_verification_rounds',
    'min_phone_verification_percent',
    'default_phone_verification_script_id'
    ]) }} as _airbyte_turfs_hashid
from {{ source('cta', 'turfs') }}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_phone_verification_scripts') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    turf_id,
    language,
    id,
    structure,
   {{ dbt_utils.surrogate_key([
     'turf_id',
    'language',
    'id',
    'structure'
    ]) }} as _airbyte_quality_control_phone_verification_scripts_hashid
from {{ source('cta', 'quality_control_phone_verification_scripts') }}

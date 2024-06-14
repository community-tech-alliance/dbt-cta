{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'turf_pvqs') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    turf_id,
    phone_verification_question_id,
   {{ dbt_utils.surrogate_key([
     'turf_id',
    'phone_verification_question_id'
    ]) }} as _airbyte_turf_pvqs_hashid
from {{ source('cta', 'turf_pvqs') }}

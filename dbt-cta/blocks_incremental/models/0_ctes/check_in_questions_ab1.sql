{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'check_in_questions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    archived,
    check_in_id,
    turf_id,
    id,
    text,
    position,
   {{ dbt_utils.surrogate_key([
     'archived',
    'check_in_id',
    'turf_id',
    'id',
    'text',
    'position'
    ]) }} as _airbyte_check_in_questions_hashid
from {{ source('cta', 'check_in_questions') }}

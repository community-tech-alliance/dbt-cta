{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'visual_review_triggers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    column,
    invert,
    record,
    match_type,
    response_id,
    custom_field,
    compare_value,
    custom_document_type,
   {{ dbt_utils.surrogate_key([
     'id',
    'column',
    'invert',
    'record',
    'match_type',
    'response_id',
    'custom_field',
    'compare_value',
    'custom_document_type'
    ]) }} as _airbyte_visual_review_triggers_hashid
from {{ source('cta', 'visual_review_triggers') }}

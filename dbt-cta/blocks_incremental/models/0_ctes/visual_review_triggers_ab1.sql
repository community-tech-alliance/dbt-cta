{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'visual_review_triggers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    custom_field,
    string_value,
    invert,
    response_id,
    record,
    column,
    match_type,
    id,
   {{ dbt_utils.surrogate_key([
     'custom_field',
    'string_value',
    'invert',
    'response_id',
    'record',
    'column',
    'match_type',
    'id'
    ]) }} as _airbyte_visual_review_triggers_hashid
from {{ source('cta', 'visual_review_triggers') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_comments') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    flag_id,
    updated_at,
    created_at,
    id,
    body,
    author_id,
   {{ dbt_utils.surrogate_key([
     'flag_id',
    'id',
    'body',
    'author_id'
    ]) }} as _airbyte_quality_control_comments_hashid
from {{ source('cta', 'quality_control_comments') }}

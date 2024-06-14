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
    id,
    body,
    flag_id,
    author_id,
    created_at,
    updated_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'body',
    'flag_id',
    'author_id'
    ]) }} as _airbyte_quality_control_comments_hashid
from {{ source('cta', 'quality_control_comments') }}

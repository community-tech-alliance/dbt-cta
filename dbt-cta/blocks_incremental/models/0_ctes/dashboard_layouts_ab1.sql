{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'dashboard_layouts') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    content,
    created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'content',
    'created_by_user_id'
    ]) }} as _airbyte_dashboard_layouts_hashid
from {{ source('cta', 'dashboard_layouts') }}

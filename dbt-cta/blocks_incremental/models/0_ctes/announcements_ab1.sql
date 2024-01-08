{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'announcements') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    starts_at,
    updated_at,
    user_id,
    created_at,
    id,
    ends_at,
    message,
   {{ dbt_utils.surrogate_key([
     'user_id',
    'id',
    'message'
    ]) }} as _airbyte_announcements_hashid
from {{ source('cta', 'announcements') }}

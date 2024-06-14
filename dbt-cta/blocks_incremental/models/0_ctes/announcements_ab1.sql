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
    id,
    ends_at,
    message,
    user_id,
    starts_at,
    created_at,
    updated_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'message',
    'user_id'
    ]) }} as _airbyte_announcements_hashid
from {{ source('cta', 'announcements') }}

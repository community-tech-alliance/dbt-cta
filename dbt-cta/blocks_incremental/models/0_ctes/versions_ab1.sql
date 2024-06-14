{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'versions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    event,
    object,
    item_id,
    item_type,
    whodunnit,
    created_at,
    object_yaml,
   {{ dbt_utils.surrogate_key([
     'id',
    'event',
    'object',
    'item_id',
    'item_type',
    'whodunnit',
    'object_yaml'
    ]) }} as _airbyte_versions_hashid
from {{ source('cta', 'versions') }}

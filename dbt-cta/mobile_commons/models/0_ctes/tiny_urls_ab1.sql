{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tiny_urls') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    key,
    url,
    host,
    mode,
    name,
    cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
    description,
   {{ dbt_utils.surrogate_key([
     'id',
    'key',
    'url',
    'host',
    'mode',
    'name',
    'created_at',
    'description'
    ]) }} as _airbyte_tiny_urls_hashid
from {{ source('cta', 'tiny_urls') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'parties') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    created_at,
    updated_at,
    description,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'description'
    ]) }} as _airbyte_parties_hashid
from {{ source('cta', 'parties') }}

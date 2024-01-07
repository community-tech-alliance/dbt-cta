{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activist_codes') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    name,
    created_at,
    id,
    label,
   {{ dbt_utils.surrogate_key([
     'name',
    'id',
    'label'
    ]) }} as _airbyte_activist_codes_hashid
from {{ source('cta', 'activist_codes') }}

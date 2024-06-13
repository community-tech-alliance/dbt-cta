
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activism_options_configs') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   issues,
   skills,
   turf_id,
   campaigns,
   languages,
   {{ dbt_utils.surrogate_key([
     'id',
    'turf_id'
    ]) }} as _airbyte_activism_options_configs_hashid
from {{ source('cta', 'activism_options_configs') }}
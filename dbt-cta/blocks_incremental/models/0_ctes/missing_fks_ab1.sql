
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'missing_fks') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   relname,
   attname,
   nspname,
   {{ dbt_utils.surrogate_key([
     'relname',
    'attname',
    'nspname'
    ]) }} as _airbyte_missing_fks_hashid
from {{ source('cta', 'missing_fks') }}
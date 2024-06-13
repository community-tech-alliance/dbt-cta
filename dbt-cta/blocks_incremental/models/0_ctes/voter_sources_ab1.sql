
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_sources') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   created_at,
   updated_at,
   description,
   date_obtained,
   {{ dbt_utils.surrogate_key([
     'id',
    'description',
    'date_obtained'
    ]) }} as _airbyte_voter_sources_hashid
from {{ source('cta', 'voter_sources') }}
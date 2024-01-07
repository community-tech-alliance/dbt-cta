
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'campaigns') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   end_date,
   updated_at,
   campaign_type,
   name,
   creator_id,
   created_at,
   id,
   start_date,
   {{ dbt_utils.surrogate_key([
     'end_date',
    'campaign_type',
    'name',
    'creator_id',
    'id',
    'start_date'
    ]) }} as _airbyte_campaigns_hashid
from {{ source('cta', 'campaigns') }}
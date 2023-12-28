
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'customer_tags') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   any_group,
   active,
   groups,
   tag_id,
   text,
   type,
   {{ dbt_utils.surrogate_key([
     'any_group',
    'active',
    'tag_id',
    'text',
    'type'
    ]) }} as _airbyte_customer_tags_hashid
from {{ source('cta', 'customer_tags') }}
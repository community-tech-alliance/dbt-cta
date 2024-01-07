
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quick_links') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   bg_color,
   size,
   updated_at,
   icon,
   link,
   created_at,
   id,
   label,
   text_color,
   block_id,
   target,
   {{ dbt_utils.surrogate_key([
     'bg_color',
    'size',
    'icon',
    'link',
    'id',
    'label',
    'text_color',
    'block_id',
    'target'
    ]) }} as _airbyte_quick_links_hashid
from {{ source('cta', 'quick_links') }}
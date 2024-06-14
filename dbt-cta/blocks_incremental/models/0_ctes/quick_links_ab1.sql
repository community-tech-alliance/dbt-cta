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
    id,
    icon,
    link,
    size,
    label,
    target,
    bg_color,
    block_id,
    created_at,
    text_color,
    updated_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'icon',
    'link',
    'size',
    'label',
    'target',
    'bg_color',
    'block_id',
    'text_color'
    ]) }} as _airbyte_quick_links_hashid
from {{ source('cta', 'quick_links') }}

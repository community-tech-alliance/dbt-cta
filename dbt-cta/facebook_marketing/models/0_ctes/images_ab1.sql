{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'images') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    url,
    name,
    width,
    height,
    status,
    url_128,
    filename,
    creatives,
    account_id,
    created_time,
    updated_time,
    permalink_url,
    original_width,
    original_height,
    is_associated_creatives_in_adgroups,
   {{ dbt_utils.surrogate_key([
     'id',
    'url',
    'name',
    'width',
    'height',
    'status',
    'url_128',
    'filename',
    'account_id',
    'created_time',
    'updated_time',
    'permalink_url',
    'original_width',
    'original_height',
    'is_associated_creatives_in_adgroups'
    ]) }} as _airbyte_images_hashid
from {{ source('cta', 'images') }}

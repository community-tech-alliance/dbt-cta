{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_core_user_page_tags_hashid'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_user_page_tags') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   tag_id,
   user_id,
   _ab_cdc_cursor,
   _ab_cdc_log_pos,
   _ab_cdc_log_file,
   _ab_cdc_deleted_at,
   _ab_cdc_updated_at,
   {{ dbt_utils.surrogate_key([
    'tag_id',
    'user_id',
    ]) }} as _airbyte_core_user_page_tags_hashid
from {{ source('cta', 'core_user_page_tags') }}

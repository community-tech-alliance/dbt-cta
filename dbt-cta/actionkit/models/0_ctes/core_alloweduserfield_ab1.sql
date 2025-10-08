{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'name'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_alloweduserfield') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   name,
   hidden,
   required,
   created_at,
   field_type,
   updated_at,
   always_show,
   description,
   field_regex,
   order_index,
   display_name,
   field_length,
   field_choices,
   field_default,
   allow_multiple
from {{ source('cta', 'core_alloweduserfield') }}

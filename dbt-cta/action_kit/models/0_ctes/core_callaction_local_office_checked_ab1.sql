{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_callaction_local_office_checked') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   callaction_id,
   _ab_cdc_cursor,
   _ab_cdc_log_pos,
   targetoffice_id,
   _ab_cdc_log_file,
   _ab_cdc_deleted_at,
   _ab_cdc_updated_at
from {{ source('cta', 'core_callaction_local_office_checked') }}

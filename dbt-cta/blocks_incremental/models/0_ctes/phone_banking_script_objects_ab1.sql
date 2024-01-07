{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_script_objects') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    is_section_divider,
    scriptable_id,
    updated_at,
    created_at,
    scriptable_type,
    script_id,
    id,
    question_id,
    position_in_script,
    script_text_id,
   {{ dbt_utils.surrogate_key([
     'is_section_divider',
    'scriptable_id',
    'scriptable_type',
    'script_id',
    'id',
    'question_id',
    'position_in_script',
    'script_text_id'
    ]) }} as _airbyte_phone_banking_script_objects_hashid
from {{ source('cta', 'phone_banking_script_objects') }}

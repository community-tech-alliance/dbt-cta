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
    id,
    script_id,
    created_at,
    updated_at,
    question_id,
    scriptable_id,
    script_text_id,
    scriptable_type,
    is_section_divider,
    position_in_script,
   {{ dbt_utils.surrogate_key([
     'id',
    'script_id',
    'question_id',
    'scriptable_id',
    'script_text_id',
    'scriptable_type',
    'is_section_divider',
    'position_in_script'
    ]) }} as _airbyte_phone_banking_script_objects_hashid
from {{ source('cta', 'phone_banking_script_objects') }}

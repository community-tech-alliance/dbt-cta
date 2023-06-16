{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_banking_script_objects_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('is_section_divider'),
        'scriptable_id',
        'updated_at',
        'created_at',
        'scriptable_type',
        'script_id',
        'id',
        'question_id',
        'position_in_script',
        'script_text_id',
    ]) }} as _airbyte_phone_banking_script_objects_hashid,
    tmp.*
from {{ ref('phone_banking_script_objects_ab2') }} tmp
-- phone_banking_script_objects
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


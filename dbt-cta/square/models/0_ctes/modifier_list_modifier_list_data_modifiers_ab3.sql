{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_modifier_list_data_hashid',
        'id',
        'type',
        'version',
        boolean_to_string('is_deleted'),
        'updated_at',
        object_to_string('modifier_data'),
        boolean_to_string('present_at_all_locations'),
    ]) }} as _airbyte_modifiers_hashid,
    tmp.*
from {{ ref('modifier_list_modifier_list_data_modifiers_ab2') }} as tmp
-- modifiers at modifier_list/modifier_list_data/modifiers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


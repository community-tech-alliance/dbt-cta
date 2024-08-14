{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('modifier_list_modifier_list_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_modifier_list_hashid',
        'name',
        array_to_string('modifiers'),
        'selection_type',
    ]) }} as _airbyte_modifier_list_data_hashid,
    tmp.*
from {{ ref('modifier_list_modifier_list_data_ab2') }} as tmp
-- modifier_list_data at modifier_list/modifier_list_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


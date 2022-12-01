{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_modifiers_hashid',
        'name',
        'ordinal',
        object_to_string('price_money'),
        boolean_to_string('on_by_default'),
        'modifier_list_id',
    ]) }} as _airbyte_modifier_data_hashid,
    tmp.*
from {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_ab2') }} tmp
-- modifier_data at modifier_list/modifier_list_data/modifiers/modifier_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


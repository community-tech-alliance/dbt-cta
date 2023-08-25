{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('modifier_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'version',
        boolean_to_string('is_deleted'),
        'updated_at',
        object_to_string('modifier_list_data'),
        boolean_to_string('present_at_all_locations'),
    ]) }} as _airbyte_modifier_list_hashid,
    tmp.*
from {{ ref('modifier_list_ab2') }} as tmp
-- modifier_list
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


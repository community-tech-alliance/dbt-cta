{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'position',
        'action_id',
        'created_at',
        'updated_at',
        boolean_to_string('is_optional'),
        'object_type',
        'object_attribute',
        'related_object_id',
        'default_response_id',
        'related_object_type',
    ]) }} as _airbyte_action_fields_hashid,
    tmp.*
from {{ ref('action_fields_ab2') }} as tmp
-- action_fields
where 1 = 1

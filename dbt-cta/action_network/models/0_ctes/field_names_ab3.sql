{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('field_names_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'notes',
        'hidden',
        'owner_id',
        'created_at',
        'owner_type',
        'syndicated',
        'updated_at',
        'validation_regexp',
        'validation_description',
    ]) }} as _airbyte_field_names_hashid,
    tmp.*
from {{ ref('field_names_ab2') }} as tmp
-- field_names
where 1 = 1

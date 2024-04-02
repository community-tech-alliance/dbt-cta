{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('field_values_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'value',
        'user_id',
        'created_at',
        'updated_at',
        'field_name_id',
    ]) }} as _airbyte_field_values_hashid,
    tmp.*
from {{ ref('field_values_ab2') }} as tmp
-- field_values
where 1 = 1

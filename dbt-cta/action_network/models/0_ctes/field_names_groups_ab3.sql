{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('field_names_groups_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'hidden',
        'group_id',
        'field_name_id',
    ]) }} as _airbyte_field_names_groups_hashid,
    tmp.*
from {{ ref('field_names_groups_ab2') }} as tmp
-- field_names_groups
where 1 = 1

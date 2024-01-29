{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entities_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'age',
        'dw_id',
        'nickname',
        'custom_id',
        'last_name',
        'created_at',
        'first_name',
        'updated_at',
        'custom_id_1',
        'custom_id_2',
        'custom_id_3',
        'custom_id_4',
        'interact_id',
        'middle_name',
        'voterbase_id',
        'created_by_id',
        'date_of_birth',
        'updated_by_id',
        'entity_type_id',
        'linked_user_id',
        'organization_id',
        'preferred_language',
        boolean_to_string('calculated_birth_date'),
    ]) }} as _airbyte_entities_hashid,
    tmp.*
from {{ ref('entities_ab2') }} as tmp
-- entities
where 1 = 1

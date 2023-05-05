{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entity_types_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'icon',
        'name_type',
        'created_at',
        'updated_at',
        'interact_id',
        'name_plural',
        boolean_to_string('email_enabled'),
        'name_singular',
        boolean_to_string('social_enabled'),
        boolean_to_string('address_enabled'),
        boolean_to_string('language_enabled'),
        boolean_to_string('phone_number_enabled'),
        boolean_to_string('date_of_birth_enabled'),
    ]) }} as _airbyte_entity_types_hashid,
    tmp.*
from {{ ref('entity_types_ab2') }} tmp
-- entity_types
where 1 = 1


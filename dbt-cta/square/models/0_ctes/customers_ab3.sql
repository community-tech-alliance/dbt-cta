{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        array_to_string('cards'),
        object_to_string('address'),
        'version',
        'birthday',
        array_to_string('group_ids'),
        'created_at',
        'given_name',
        'updated_at',
        'family_name',
        object_to_string('preferences'),
        array_to_string('segment_ids'),
        'company_name',
        'phone_number',
        'reference_id',
        'email_address',
        'creation_source',
    ]) }} as _airbyte_customers_hashid,
    tmp.*
from {{ ref('customers_ab2') }} as tmp
-- customers
where 1 = 1

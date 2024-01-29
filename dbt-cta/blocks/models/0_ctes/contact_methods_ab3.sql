{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contact_methods_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'extension',
        'contact_type',
        'updated_at',
        boolean_to_string('invalid'),
        'created_at',
        'description',
        'id',
        'content',
        'person_id',
    ]) }} as _airbyte_contact_methods_hashid,
    tmp.*
from {{ ref('contact_methods_ab2') }} tmp
-- contact_methods
where 1 = 1


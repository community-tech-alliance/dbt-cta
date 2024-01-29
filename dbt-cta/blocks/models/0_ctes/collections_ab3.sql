{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('collections_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'name',
        boolean_to_string('active'),
        'created_at',
        'id',
        'collection_type',
        'created_by_user_id',
    ]) }} as _airbyte_collections_hashid,
    tmp.*
from {{ ref('collections_ab2') }} tmp
-- collections
where 1 = 1


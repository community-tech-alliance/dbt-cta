{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('officials_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'fax',
        'email',
        'phone',
        'title',
        'office',
        'suffix',
        'initial',
        'last_name',
        'first_name',
        'office_name',
        'office_type',
        'resource_uri',
    ]) }} as _airbyte_officials_hashid,
    tmp.*
from {{ ref('officials_ab2') }} tmp
-- officials
where 1 = 1


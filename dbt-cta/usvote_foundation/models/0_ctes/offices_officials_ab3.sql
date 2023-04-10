{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('offices_officials_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_offices_hashid',
        'id',
        'fax',
        'email',
        'phone',
        'title',
        'suffix',
        'initial',
        'last_name',
        'first_name',
        'office_uri',
        'office_type',
        'resource_uri',
    ]) }} as _airbyte_officials_hashid,
    tmp.*
from {{ ref('offices_officials_ab2') }} tmp
-- officials at offices/officials
where 1 = 1


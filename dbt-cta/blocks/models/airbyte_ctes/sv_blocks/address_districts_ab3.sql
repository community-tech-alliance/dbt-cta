{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('address_districts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'address_id',
        'district_id',
        'district_type',
    ]) }} as _airbyte_address_districts_hashid,
    tmp.*
from {{ ref('address_districts_ab2') }} tmp
-- address_districts
where 1 = 1


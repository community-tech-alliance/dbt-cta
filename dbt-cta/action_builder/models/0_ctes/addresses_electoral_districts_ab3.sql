{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('addresses_electoral_districts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'address_id',
        'electoral_district_ocd_id',
    ]) }} as _airbyte_addresses_electoral_districts_hashid,
    tmp.*
from {{ ref('addresses_electoral_districts_ab2') }} as tmp
-- addresses_electoral_districts
where 1 = 1

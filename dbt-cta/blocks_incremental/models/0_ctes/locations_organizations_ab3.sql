{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('locations_organizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'organization_id',
        'location_id',
    ]) }} as _airbyte_locations_organizations_hashid,
    tmp.*
from {{ ref('locations_organizations_ab2') }} as tmp
-- locations_organizations
where 1 = 1

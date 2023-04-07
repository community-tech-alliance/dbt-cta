{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('regions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'state',
        'county',
        'state_abbr',
        'state_name',
        'county_name',
        'region_name',
        'municipality',
        'resource_uri',
        'municipality_name',
        'municipality_type',
    ]) }} as _airbyte_regions_hashid,
    tmp.*
from {{ ref('regions_ab2') }} tmp
-- regions
where 1 = 1


{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'organization_memberships') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    member_id,
    created_at,
    updated_at,
    responsibility,
    organization_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'member_id',
    'responsibility',
    'organization_id'
    ]) }} as _airbyte_organization_memberships_hashid
from {{ source('cta', 'organization_memberships') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'roles') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    needs_training,
    admin,
    created_at,
    description,
    abilities,
    depth,
    updated_at,
    parent_id,
    permissions,
    name,
    id,
    lft,
    rgt,
    dashboard_layout_id,
   {{ dbt_utils.surrogate_key([
     'needs_training',
    'admin',
    'description',
    'abilities',
    'depth',
    'parent_id',
    'permissions',
    'name',
    'id',
    'lft',
    'rgt',
    'dashboard_layout_id'
    ]) }} as _airbyte_roles_hashid
from {{ source('cta', 'roles') }}


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
   id,
   lft,
   rgt,
   name,
   admin,
   depth,
   abilities,
   parent_id,
   created_at,
   updated_at,
   description,
   permissions,
   needs_training,
   dashboard_layout_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'lft',
    'rgt',
    'name',
    'admin',
    'depth',
    'abilities',
    'parent_id',
    'description',
    'permissions',
    'needs_training',
    'dashboard_layout_id'
    ]) }} as _airbyte_roles_hashid
from {{ source('cta', 'roles') }}
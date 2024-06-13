
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tenant_quick_links') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   tenant_id,
   created_at,
   updated_at,
   quick_link_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'tenant_id',
    'quick_link_id'
    ]) }} as _airbyte_tenant_quick_links_hashid
from {{ source('cta', 'tenant_quick_links') }}
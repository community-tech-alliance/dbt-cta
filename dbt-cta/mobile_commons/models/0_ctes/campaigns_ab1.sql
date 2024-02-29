{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'campaigns') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    tags,
    active,
    description,
    opt_in_paths,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'active',
    'description'
    ]) }} as _airbyte_campaigns_hashid
from {{ source('cta', 'campaigns') }}

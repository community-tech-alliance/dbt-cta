{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voted_labels') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    code,
    state,
    created_at,
    updated_at,
    description,
   {{ dbt_utils.surrogate_key([
     'code',
    'state',
    'description'
    ]) }} as _airbyte_voted_labels_hashid
from {{ source('cta', 'voted_labels') }}

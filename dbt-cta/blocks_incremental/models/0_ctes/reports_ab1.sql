{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'reports') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    date,
    collection_id,
    updated_at,
    user_id,
    qualitative_metrics,
    quantitative_metrics,
    created_at,
    id,
   {{ dbt_utils.surrogate_key([
     'date',
    'collection_id',
    'user_id',
    'qualitative_metrics',
    'quantitative_metrics',
    'id'
    ]) }} as _airbyte_reports_hashid
from {{ source('cta', 'reports') }}

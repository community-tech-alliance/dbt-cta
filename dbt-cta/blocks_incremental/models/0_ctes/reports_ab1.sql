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
    id,
    date,
    user_id,
    created_at,
    updated_at,
    collection_id,
    qualitative_metrics,
    quantitative_metrics,
   {{ dbt_utils.surrogate_key([
     'id',
    'date',
    'user_id',
    'collection_id',
    'qualitative_metrics',
    'quantitative_metrics'
    ]) }} as _airbyte_reports_hashid
from {{ source('cta', 'reports') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'metrics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    label,
    required,
    created_at,
    updated_at,
    metric_type,
    show_on_leaderboard,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'label',
    'required',
    'metric_type',
    'show_on_leaderboard'
    ]) }} as _airbyte_metrics_hashid
from {{ source('cta', 'metrics') }}

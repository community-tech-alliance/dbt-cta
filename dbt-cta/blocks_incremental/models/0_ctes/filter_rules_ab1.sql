
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'filter_rules') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   param,
   column,
   operator,
   created_at,
   updated_at,
   filter_view_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'param',
    'column',
    'operator',
    'filter_view_id'
    ]) }} as _airbyte_filter_rules_hashid
from {{ source('cta', 'filter_rules') }}
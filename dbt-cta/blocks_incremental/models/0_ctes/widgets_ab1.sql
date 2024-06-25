{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'widgets') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    block_id,
    created_at,
    updated_at,
    column_span,
    widget_type,
    measurable_type,
    number_of_measurables,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'block_id',
    'column_span',
    'widget_type',
    'measurable_type',
    'number_of_measurables'
    ]) }} as _airbyte_widgets_hashid
from {{ source('cta', 'widgets') }}

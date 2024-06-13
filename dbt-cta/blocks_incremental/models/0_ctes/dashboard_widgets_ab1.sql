
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'dashboard_widgets') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   title,
   position,
   widget_id,
   created_at,
   updated_at,
   measurable_ids,
   measurable_type,
   dashboard_layout_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'title',
    'position',
    'widget_id',
    'measurable_type',
    'dashboard_layout_id'
    ]) }} as _airbyte_dashboard_widgets_hashid
from {{ source('cta', 'dashboard_widgets') }}
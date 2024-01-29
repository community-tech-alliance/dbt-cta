{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('widgets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'name',
        'created_at',
        'id',
        'number_of_measurables',
        'column_span',
        'block_id',
        'widget_type',
        'measurable_type'
    ]) }} as _airbyte_widgets_hashid,
    tmp.*
from {{ ref('widgets_ab2') }} as tmp
-- widgets
where 1 = 1

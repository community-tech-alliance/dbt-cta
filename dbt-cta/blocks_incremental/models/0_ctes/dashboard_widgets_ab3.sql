{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('dashboard_widgets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'widget_id',
        'updated_at',
        array_to_string('measurable_ids'),
        'created_at',
        'id',
        'position',
        'title',
        'measurable_type',
        'dashboard_layout_id',
    ]) }} as _airbyte_dashboard_widgets_hashid,
    tmp.*
from {{ ref('dashboard_widgets_ab2') }} as tmp
-- dashboard_widgets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


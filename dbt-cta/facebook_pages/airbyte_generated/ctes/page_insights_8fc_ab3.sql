{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_default",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_insights_8fc_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'period',
        array_to_string('values'),
        'name',
        'description',
        'id',
        'title',
    ]) }} as _airbyte_page_insights_hashid,
    tmp.*
from {{ ref('page_insights_8fc_ab2') }} tmp
-- page_insights
where 1 = 1


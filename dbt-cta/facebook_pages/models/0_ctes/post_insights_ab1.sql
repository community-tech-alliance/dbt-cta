{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta','post_insights') }}
select
    {{ dbt_utils.surrogate_key([
        'period',
        'name',
        'description',
        'id',
        'title',
    ]) }} as _airbyte_post_insights_hashid,
    tmp.*
from {{ source('cta','post_insights') }} as tmp
-- post_insights
where 1 = 1

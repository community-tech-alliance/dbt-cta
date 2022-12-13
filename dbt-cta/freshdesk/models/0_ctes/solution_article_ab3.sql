{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('solution_article_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'hits',
        array_to_string('tags'),
        'title',
        'status',
        'agent_id',
        object_to_string('seo_data'),
        'folder_id',
        'thumbs_up',
        'created_at',
        'updated_at',
        'category_id',
        'description',
        'thumbs_down',
        'description_text',
    ]) }} as _airbyte_solution_articles_hashid,
    tmp.*
from {{ ref('solution_article_ab2') }} tmp
-- solution_articles
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_engagement_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        'social_sentence_without_like',
        'count_string',
        'social_sentence_with_like',
        'count_string_without_like',
        'count',
        'count_string_with_like',
        'social_sentence',
    ]) }} as _airbyte_engagement_hashid,
    tmp.*
from {{ ref('page_engagement_ab2') }} tmp
-- engagement at page/engagement
where 1 = 1


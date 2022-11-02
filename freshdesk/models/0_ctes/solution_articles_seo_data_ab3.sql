{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('solution_articles_seo_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_solution_articles_hashid',
        'meta_title',
        array_to_string('meta_keywords'),
        'meta_description',
    ]) }} as _airbyte_seo_data_hashid,
    tmp.*
from {{ ref('solution_articles_seo_data_ab2') }} tmp
-- seo_data at solution_articles/seo_data
where 1 = 1


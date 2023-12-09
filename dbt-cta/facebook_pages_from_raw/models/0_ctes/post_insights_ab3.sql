{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
) }}

{% set raw_source_name = var('cta_dataset_id') + "_raw__stream_page" %}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('post_insights_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'period',
        array_to_string('values'),
        'name',
        'description',
        'id',
        'title',
    ]) }} as _airbyte_post_insights_hashid,
    tmp.*
from {{ ref('post_insights_ab2') }} tmp
-- post_insights
where 1 = 1


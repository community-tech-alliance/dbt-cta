{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'title',
        'hidden',
        'status',
        'user_id',
        'group_id',
        'language',
        'permalink',
        'created_at',
        'updated_at',
        'first_publish',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'description_text',
        'image_attribution',
        'photo_content_type',
        'administrative_title',
    ]) }} as _airbyte_campaigns_hashid,
    tmp.*
from {{ ref('campaigns_ab2') }} tmp
-- campaigns
where 1 = 1


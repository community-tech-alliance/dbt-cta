{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_connected_instagram_account_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'website',
        'shopping_review_status',
        'media_count',
        'followers_count',
        'profile_picture_url',
        'name',
        'follows_count',
        'id',
        'ig_id',
        'biography',
        'username',
    ]) }} as _airbyte_connected_instagram_account_hashid,
    tmp.*
from {{ ref('page_connected_instagram_account_ab2') }} tmp
-- connected_instagram_account at page/connected_instagram_account
where 1 = 1


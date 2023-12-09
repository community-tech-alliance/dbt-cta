{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_instagram_business_account_ab2') }}
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
    ]) }} as _airbyte_instagram_business_account_hashid,
    tmp.*
from {{ ref('page_instagram_business_account_ab2') }} tmp
-- instagram_business_account at page/instagram_business_account
where 1 = 1


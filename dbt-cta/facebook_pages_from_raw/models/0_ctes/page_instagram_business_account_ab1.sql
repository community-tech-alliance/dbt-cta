{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('instagram_business_account', ['website'], ['website']) }} as website,
    {{ json_extract_scalar('instagram_business_account', ['shopping_review_status'], ['shopping_review_status']) }} as shopping_review_status,
    {{ json_extract_scalar('instagram_business_account', ['media_count'], ['media_count']) }} as media_count,
    {{ json_extract_scalar('instagram_business_account', ['followers_count'], ['followers_count']) }} as followers_count,
    {{ json_extract_scalar('instagram_business_account', ['profile_picture_url'], ['profile_picture_url']) }} as profile_picture_url,
    {{ json_extract_scalar('instagram_business_account', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('instagram_business_account', ['follows_count'], ['follows_count']) }} as follows_count,
    {{ json_extract_scalar('instagram_business_account', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('instagram_business_account', ['ig_id'], ['ig_id']) }} as ig_id,
    {{ json_extract_scalar('instagram_business_account', ['biography'], ['biography']) }} as biography,
    {{ json_extract_scalar('instagram_business_account', ['username'], ['username']) }} as username,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- instagram_business_account at page/instagram_business_account
where 1 = 1
and instagram_business_account is not null


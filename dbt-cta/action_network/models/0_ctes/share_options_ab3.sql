{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('share_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        adapter.quote('from'),
        'message',
        'subject',
        'reply_to',
        'share_id',
        'created_at',
        'share_type',
        'updated_at',
        'direct_link',
        'email_share',
        'redirect_url',
        'facebook_link',
        'twitter_share',
        'arbitrary_html',
        'email_response',
        'facebook_share',
        'facebook_title',
        'limit_redirect',
        'email_template_id',
        'facebook_pixel_id',
        'google_conversion_id',
        'unpublished_redirect',
        'speechifai_email_html',
        'speechifai_campaign_id',
        'google_conversion_label',
        'facebook_image_file_name',
        'facebook_image_file_size',
        'facebook_image_content_type',
    ]) }} as _airbyte_share_options_hashid,
    tmp.*
from {{ ref('share_options_ab2') }} as tmp
-- share_options
where 1 = 1
